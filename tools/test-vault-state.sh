#!/usr/bin/env bash
# Regression checks for snapshot dates, review boundaries, and timezone parity.
set -euo pipefail

repo_root=$(cd "$(dirname "$0")/.." && pwd -P)
temp_root=$(cd "${TMPDIR:-/tmp}" && pwd -P)
test_root=$(mktemp -d "$temp_root/intel-codex-state.XXXXXX")
test_root=$(cd "$test_root" && pwd -P)
cleanup() {
  case "$test_root" in
    "$temp_root"/intel-codex-state.*) rm -rf -- "$test_root" ;;
    *) echo "Refusing to remove unexpected test path: $test_root" >&2 ;;
  esac
}
trap cleanup EXIT

mkdir -p "$test_root"/{tools,.omc,Investigations/{Platforms,Techniques},Security/{Analysis,Pentesting}}
cp "$repo_root/tools/build-vault-state.sh" "$test_root/tools/"
cd "$test_root"
cat > README.md <<'EOF'
# Fixture vault
<!-- vault-state:begin -->
outdated count
<!-- vault-state:end -->
EOF

write_sop() {
  cat > "Investigations/Platforms/sop-$1.md" <<EOF
---
title: $1
updated: 2026-10-07
---
$2
EOF
}
write_sop current '[verify 2026-07-09]'
write_sop due '[verify 2026-07-08]'
write_sop boundary '[verify 2026-04-10]'
write_sop overdue '[verify 2026-04-09]'
write_sop unchecked ''

TZ=Pacific/Kiritimati VAULT_AS_OF=2026-10-07 bash tools/build-vault-state.sh >/dev/null
for row in '| 90 | current |' '| 91 | review due |' '| 180 | review due |' '| 181 | overdue |' \
  '| current (≤ 90 days) | 1 |' '| review due (91–180 days) | 2 |' \
  '| overdue (> 180 days) | 1 |' '| no source checks recorded | 1 |'; do
  grep -Fq "$row" Verification-Status.md
done
grep -Fq '**5 SOPs** · 5 investigation · 0 security' README.md
cp Verification-Status.md status.expected
cp .omc/vault-state.md state.expected
cp README.md readme.expected

TZ=America/New_York VAULT_AS_OF=2026-10-07 bash tools/build-vault-state.sh >/dev/null
cmp status.expected Verification-Status.md
cmp state.expected .omc/vault-state.md
cmp readme.expected README.md

# Reject bad input before overwriting any generated file.
for invalid in 2026-02-30 2026-2-03 tomorrow; do
  if VAULT_AS_OF="$invalid" bash tools/build-vault-state.sh >/dev/null 2>&1; then
    echo "Invalid date accepted: $invalid" >&2
    exit 1
  fi
  cmp status.expected Verification-Status.md
  cmp state.expected .omc/vault-state.md
  cmp readme.expected README.md
done

echo "OK: snapshot dates, review boundaries, and timezone parity."
