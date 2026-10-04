# AKZ themes for Issabel and VOIZ

English/LTR and Persian/RTL editions of the AKZ interface, with compiled assets and unattended theme installation. This is the public source repository; it does not install a PBX.

| Branch | Contents | Install from its extracted root |
|---|---|---|
| [en](https://github.com/akzwp/akz_issable_theme/tree/en) | English package, theme `akz` | `sudo bash install.sh` |
| [fa](https://github.com/akzwp/akz_issable_theme/tree/fa) | Persian package, theme `akzfa` | `sudo bash install.sh` |
| main | Both source packages and upstream proposals | `sudo bash install.sh en` or `sudo bash install.sh fa` |

No Node.js, npm, asset compilation or downloads run on the server. Installation activates the edition and its language by default. Standard Issabel system tools and layout are required; the Persian edition also requires the existing Persian language pack. See [English installation](en-theme/INSTALL.md) or [Persian installation](fa-theme/INSTALL.md).

## Persian 2.0.1 follow-up

The Persian branch now has Persian documentation. Direct edits previously present only in the local runtime CSS have been recovered into its build sources: icon definitions, calendar presentation and the network switch. VOIZ module class compatibility is retained. Installers refresh deployed source timestamps and print the package version; reinstalling an old download does not fetch a new version. See the [Persian update guide](fa-theme/README.md).

## Changes in the initial revision

- Restore the newer local calendar dialog and color-picker changes missing from the GitHub exports; align switches and radio buttons across both editions.
- Correct English color labels, popup centering and stale selector namespaces; add missing Persian icon styles and remove unused login/demo script loading.
- Generate the distributed CSS from the updated sources.
- Provide root install/uninstall commands, shared edition locking, guarded activation, private backups and recovery that respects later administrator choices.
- Exclude the inherited theme-local phone backend; existing PBX/webphone installations remain separate.
- Export each language package to its own branch with its existing history retained.

## Proposals and maintenance

[Issabel adoption proposal](proposals/01-issabel-framework/PROPOSAL.md) · [VOIZ adoption proposal](proposals/02-voiz-upstream/PROPOSAL.md) · [Maintenance workflow](ROADMAP.md)

The goal is upstream default-theme adoption after review and owner evaluation. These are prepared proposal documents; no upstream pull requests have been opened. **No browser or other tests were run for this revision.** Source comparison and CSS generation do not establish runtime compatibility.

Keep the original [license](LICENSE), component notices and file headers. AKZ identifies the interface contribution and does not imply endorsement by Issabel or VOIZ.
