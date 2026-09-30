# AKZ Persian theme development (akzfa)

The runtime directory is `../../framework/html/themes/akzfa` relative to this directory.
Keep both directories in the same checkout. This package lives under `fa-theme/` in the
[akz_issable_theme](https://github.com/akzwp/akz_issable_theme) repository; install paths below are
relative to the repository root.

## Installation on Issabel

From the repository root run:

```sh
sudo bash fa-theme/contrib/akzfa-theme/install.sh --activate
```

to install the theme and select Persian (`fa`) with the `akzfa` theme. Omit `--activate` to install
files without changing the current selection. Run `sudo bash fa-theme/contrib/akzfa-theme/uninstall.sh`
to archive the theme and restore the saved selection. State is kept in `/var/lib/issabel/akzfa-theme`
(root-only). Sign out and sign in again after changing the selection.

## Editing and building

```sh
cd fa-theme/contrib/akzfa-theme
npm ci --ignore-scripts
npm run build:css
```

Source CSS lives in `ui/` (`ui/akzfa-theme.css` is the entry point). Output is
`../../framework/html/themes/akzfa/css/akzfa-tailwind.css`. Tailwind preflight is disabled to
preserve legacy widget behavior. Commit source and compiled CSS together. The server uses the
prebuilt files and does not need Node.js.

JavaScript lives in the runtime theme's `js/akzfa-ui.js` and `js/akzfa-embedded.js`. Design tokens
are CSS variables with the `--akzfa-` prefix. Optional branding (footer/version) can be placed at
`/etc/akzfa.conf`; the theme falls back to safe defaults when the file is absent.

## Licenses

- Theme code: GPL-2.0-or-later (`LICENSES/GPL-2.0-or-later.txt`).
- Vazirmatn font: SIL Open Font License 1.1 (`LICENSES/Vazirmatn/OFL-1.1.txt`).
- Framework-derived files retain their original PaloSanto/Issabel file-level notices.
