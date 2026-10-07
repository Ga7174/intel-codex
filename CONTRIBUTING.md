# Contributing to Intel Codex

Thank you for your interest in contributing to **Intel Codex** — a knowledge‑base covering OSINT, reverse engineering, malware analysis, cryptography and intelligence frameworks for security researchers.  

We welcome contributions of all kinds: new SOPs (Standard Operating Procedures), improvements to existing content, bug‑fixes in markup or links, structural/navigation updates, etc.

---

## ✅ How to Contribute

1. Fork the repository and clone it locally:  
   ```bash
   git clone https://github.com/gl0bal01/intel-codex.git
   ```
2. Create a new branch for your work:  
   ```bash
   git checkout -b feature/your-topic
   ```
3. Make your changes (see “Style & Structure” below).
4. Update the navigation index (`README.md` and `index.md`) if you add or change content.
5. Commit your changes with a meaningful commit message.
6. Push your branch to your fork and open a Pull Request (PR) against `main`.

---

## 📁 Style & Structure

To keep the vault consistent and easy to navigate, please follow the naming and formatting conventions below:

### File naming
- For new SOPs under **Investigations** or **Security**: `sop-<topic>.md`
- For platform-specific guides: `sop-platform-<name>.md`
- E.g.: `sop-twitter-x-investigation.md`, `sop-reverse-shell-analysis.md`

### Folder structure  
```
ObsidianVault/
├── README.md                      # Start here – main navigation hub  
├── Investigations/                # OSINT techniques & platform guides
│   ├── Platforms/                 # Platform-specific SOPs (Twitter, Telegram, Instagram, etc.)
│   └── Techniques/                # Investigation methods (OPSEC, legal/ethics, image-analysis, etc.)  
├── Security/                      # Malware analysis & pentesting
│   ├── Analysis/                  # Malware, reverse-engineering, cryptography
│   └── Pentesting/                # Web, mobile, AD, vulnerability research
└── Cases/                         # Investigation management & examples
    ├── Case-Template/            # Blank case structure for new investigations
    └── 2025-001-Example-Investigation/  # Complete case example  
```

### Content requirements  
- Start your SOP with a clear title and summary of what the SOP covers.  
- Provide copy‑paste ready commands for Windows/Linux/macOS where applicable.  
- Link to any relevant other SOPs or resources inside the vault for cross‑reference.  
- Include a section at the bottom discussing **Legal & Ethics** (with any relevant disclaimers) if your SOP involves investigations, OSINT, or adversary tactics.  
- Ensure links and internal references are working, and that markdown formatting is consistent.

---

## 🔍 Review Process

### Local vault checks

Run `./tools/check-vault.sh` to check the vault, then
`./tools/build-vault-state.sh` to refresh the inventory, README counts, and
verification report. Commit the generated files with your content changes.
Run `bash tools/test-vault-state.sh` when changing snapshot generation.

The generator uses today's UTC date by default. To reproduce a published
report without advancing its date or verification ages, use
`VAULT_AS_OF=YYYY-MM-DD ./tools/build-vault-state.sh` with the `generated:` date
from `Verification-Status.md`. CI uses that recorded date to check for content
drift; the lint check still evaluates source freshness against the current date.

When you submit your PR, it will be reviewed by a maintainer. The review may include:

- Checking markup/layout consistency  
- Verifying that new additions follow the naming/structural conventions  
- Ensuring content is accurate, clear, and properly referenced  
- Confirming that any added dependencies (e.g., external tools or links) are valid and appropriate for this knowledge base  

Please respond to review comments promptly so we can merge your contribution quickly.

---

## 🎉 Why Contribute?

- Help grow a **free and open** resource for investigators, security professionals, and learners.  
- Share your expertise on OSINT, malware, reverse engineering, cryptography, …
- Build your visibility in the security‑research community.  
- Improve your own documentation and teaching skills by writing clear SOPs for others.

---

## 📜 Code of Conduct

By participating in this project, you agree to abide by the [Contributor Covenant](https://www.contributor-covenant.org/) Code of Conduct. In short: be respectful, considerate, and professional.  
Any reports of harassment or inappropriate behavior can be submitted via GitHub issues or by contacting the maintainers directly.

---

## ⚖️ Legal & Ethics Disclaimer

This repository is strictly for **educational and authorized investigative purposes only**.  
Before applying any technique or tool described here:

- Ensure you have proper authorization.  
- Respect all relevant laws and regulations (e.g., GDPR, CCPA, local jurisdiction).  
- Escalate sensitive crimes appropriately (see the “Escalation” SOP).  
- The repository author(s) assume no liability for misuse of the content.

---

Thanks again for your interest in contributing. We look forward to collaborating with you!

– The Intel Codex Team
