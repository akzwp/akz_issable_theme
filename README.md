# akz_issable_theme — AKZ Themes for Issabel

Professional UI themes for the **Issabel** PBX web panel — Persian (RTL) and English (LTR) editions
of the same architecture, plus upstream proposals.

| Directory | What it is |
|---|---|
| [`fa-theme/`](fa-theme/README.md) | **Persian RTL theme `akzfa`** — Vazirmatn font, dark/light, responsive, installer + uninstaller, Tailwind build sources |
| [`en-theme/`](en-theme/README.md) | **English LTR theme `akz`** — same architecture, system fonts |
| [`proposals/`](proposals/00-INDEX.md) | Professional proposals for the upstream repos (`IssabelFoundation/framework`, `voipiran/VOIZ`) |
| [`ROADMAP.md`](ROADMAP.md) | Step-by-step plan: branches → validation → upstream PRs |

**Branch layout of this repository:**

| Branch | Content |
|---|---|
| `main` | This index: shared sources, docs, proposals |
| `fa` | Persian theme package only |
| `en` | English theme package only |

## Quick start (Persian theme)

```bash
sudo bash fa-theme/contrib/akzfa-theme/install.sh --activate
# Sign out and sign in again.
```

Details: [`fa-theme/README.md`](fa-theme/README.md) · Architecture: [`fa-theme/ARCHITECTURE.md`](fa-theme/ARCHITECTURE.md)
Compatibility & test plan: [`fa-theme/COMPATIBILITY.md`](fa-theme/COMPATIBILITY.md)

## License

GPL-2.0-or-later (matching the Issabel framework) — see [`LICENSE`](LICENSE).
Bundled fonts: Vazirmatn, SIL OFL 1.1 (license text included in `fa-theme/contrib/akzfa-theme/LICENSES/`).
"AKZ" identifies the interface contribution; it does not claim ownership of Issabel.
