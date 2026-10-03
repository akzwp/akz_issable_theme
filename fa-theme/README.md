# AKZ — Persian / RTL

A presentation theme for an existing Issabel PBX, distributed as `akzfa`. It provides light/dark appearance, responsive navigation and module search, consistent forms and tables, and calendar dialog controls. Existing framework authentication and module processing remain in control.

## نصب / Install

برای نصب، شاخهٔ fa را روی سرور دریافت و استخراج کنید و دستور زیر را در پوشهٔ آن اجرا کنید. نیازی به Node.js یا npm نیست. پس از نصب یک بار خارج و دوباره وارد شوید.

Download and extract the [fa branch](https://github.com/akzwp/akz_issable_theme/tree/fa) on the server, then run from the extracted directory:

```sh
sudo bash install.sh
```

Installation and language selection are unattended. No Node.js, npm, dependency download or CSS build is needed on the server. Sign out and sign in again.

[Requirements, installation scope and recovery](INSTALL.md) · [Upstream proposal](PULL_REQUEST.md)

`sudo bash install.sh --no-activate` installs files without selecting the theme. `sudo bash uninstall.sh` restores the prior selection if this theme is active and retains files for recovery.

## Source and maintenance

The authoring source is [main/fa-theme](https://github.com/akzwp/akz_issable_theme/tree/main/fa-theme). This branch is its complete installable package. Edit on main, commit source and generated CSS together, then export this directory to the corresponding language branch. Optional development tooling in `contrib/akzfa-theme` is never executed by the installer.

The source reference is the local VOIZ theme/vitenant and ui snapshot. Calendar controls, radio buttons and switches are aligned with the newer local work; namespacing and direction-specific behavior are retained. Vazirmatn fonts are served locally. Existing Persian translations and calendar support are prerequisites; this is not a language pack.

## Status and licensing

This revision has not been tested. Browser and server evaluation will be performed by the owner before proposing a default-theme migration. No accessibility, performance or security certification is claimed.

Retain [LICENSE](LICENSE), file headers and [third-party notices](contrib/akzfa-theme/THIRD_PARTY_NOTICES.md). AKZ identifies the interface contribution, not authorship of the whole framework or upstream endorsement.
