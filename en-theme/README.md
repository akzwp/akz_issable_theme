# AKZ — English / LTR

A presentation theme for an existing Issabel PBX, distributed as `akz`. It provides light/dark appearance, responsive navigation and module search, consistent forms and tables, and calendar dialog controls. Existing framework authentication and module processing remain in control.

## Install

Download and extract the [en branch](https://github.com/akzwp/akz_issable_theme/tree/en) on the server, then run from the extracted directory:

```sh
sudo bash install.sh
```

Installation and language selection are unattended. No Node.js, npm, dependency download or CSS build is needed on the server. Sign out and sign in again.

[Requirements, installation scope and recovery](INSTALL.md) · [Upstream proposal](PULL_REQUEST.md)

`sudo bash install.sh --no-activate` installs files without selecting the theme. `sudo bash uninstall.sh` restores the prior selection if this theme is active and retains files for recovery.

## Source and maintenance

The authoring source is [main/en-theme](https://github.com/akzwp/akz_issable_theme/tree/main/en-theme). This branch is its complete installable package. Edit on main, commit source and generated CSS together, then export this directory to the corresponding language branch. Optional development tooling in `contrib/akz-theme` is never executed by the installer.

The source reference is the local english_issable_akz snapshot. Calendar controls, radio buttons and switches are aligned with the newer local work; namespacing and direction-specific behavior are retained. Theme-owned labels use English and the sidebar uses LTR layout.

## Status and licensing

This revision has not been tested. Browser and server evaluation will be performed by the owner before proposing a default-theme migration. No accessibility, performance or security certification is claimed.

Retain [LICENSE](LICENSE), file headers and [third-party notices](contrib/akz-theme/THIRD_PARTY_NOTICES.md). AKZ identifies the interface contribution, not authorship of the whole framework or upstream endorsement.
