# Issabel AKZ English Theme

An independent English, left-to-right edition of the AKZ interface for an existing Issabel installation. The runtime theme is in `framework/html/themes/akz`; editable styles and installation tools are in `contrib/akz-theme`.

The interface includes a responsive left sidebar, searchable navigation, light and dark appearances, readable tables and forms, accessible dialog controls, consistent notifications, and Gregorian calendar styling. Authentication and module requests remain under the installed Issabel framework's control.

## Install

Copy this complete directory to an existing Issabel server. The installer expects the standard `/var/www/html` and `/var/www/db/settings.db` layout and an installed `tenant` theme.

```sh
sudo bash contrib/akz-theme/install.sh --activate
```

This installs the separate `akz` theme and selects English. Sign out and sign in again. Omit `--activate` to install the files without changing the current theme or language. No build tools are required on the server; compiled CSS is included.

To restore the previous theme and language:

```sh
sudo bash contrib/akz-theme/uninstall.sh
```

The installer saves the previous selection under `/var/lib/issabel/akz-theme`. Upgrades archive the previous theme files. Uninstallation archives the package instead of deleting it, and preserves a different theme selection made after installation.

## Build the CSS

Use a current Node.js LTS release on a development computer:

```sh
cd contrib/akz-theme
npm ci --ignore-scripts
npm run build:css
```

Commit both the source styles and the generated `framework/html/themes/akz/css/akz-tailwind.css`. JavaScript is shipped as readable source.

## Scope and status

This is a theme-only distribution. It does not install a PBX, bundled applications, sound packs, dialplan changes, database replacements, or a separate language pack. Stock Issabel supplies English module translations and Gregorian calendar behavior. User-entered names and messages are left unchanged. Embedded PBX pages are styled only while displayed inside this theme; their application files are not overwritten.

The source was converted and the distributable CSS was generated. Browser, application, installation, automated, and compatibility tests have **not** been run. Compatibility with a particular Issabel build must be established on a separate server before deploying or marking a pull request ready for review.

This package is a contribution candidate, not an official Issabel release or an accepted upstream change. See [PUSH_GUIDE.md](PUSH_GUIDE.md) for the submission workflow and [PULL_REQUEST.md](PULL_REQUEST.md) for a draft description.

## Licensing

Retain `LICENSE`, [third-party notices](contrib/akz-theme/THIRD_PARTY_NOTICES.md), and existing file headers. The framework-derived files retain their original notices; the inherited MIT notice is provided separately. AKZ identifies the interface contribution, not authorship of the entire Issabel framework.
