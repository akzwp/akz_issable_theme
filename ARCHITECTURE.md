# AKZ Persian architecture

The package installs `framework/html/themes/akzfa` as `/var/www/html/themes/akzfa`. Framework selection, authentication, menu authorization and module processing remain in the host application. `themesetup.php` supplies the inherited Smarty menu/notification assignments and a local package version. No external branding configuration is required.

- `_common/*.tpl`: Persian RTL shell, navigation, login and popup markup.
- `contrib/akzfa-theme/ui/*.css`: editable colors, layout, forms, tables, calendar and embedded-module styles.
- `css/akzfa-tailwind.css`: compiled distribution stylesheet, loaded after framework/module headers. The legacy cascade uses targeted specificity and !important rules; it is not isolation from every module stylesheet.
- `js/akzfa-ui.js`: theme switching, navigation/search, controls and same-origin iframe styling.
- `js/akzfa-embedded.js`: embedded PBX presentation behavior. Cross-origin documents are not modified.
- `fonts/vazirmatn`: local fonts with the included license.

The export maps the local VOIZ UI namespace to akzfa, including calendar swatch selectors. The English edition has separate LTR styles and English labels. Both share the installer implementation. Compiled CSS is distributed; the developer-only Tailwind toolchain has preflight disabled and a tw- utility prefix.

The package does not include the inherited theme-local phone backend, a replacement database, language packs or a Jalali calendar engine. It may link to already installed host applications. See [installation and recovery](INSTALL.md), [compatibility status](COMPATIBILITY.md), and [the proposal](PULL_REQUEST.md).
