# Source and third-party notices

AKZ contributes the interface layout, appearance, accessibility improvements, Persian RTL
presentation, and packaging. This attribution does not claim authorship of the Issabel framework
or its bundled libraries.

## Framework-derived code

The theme templates and setup code derive from the Issabel framework (via the `voipiran/VOIZ`
Persian distribution, GPL-2.0-or-later) and retain existing PaloSanto Solutions and other
file-level copyright notices. The Issabel framework describes its licensing as GPLv2 or later.
A copy of that license text is included in `LICENSES/GPL-2.0-or-later.txt`.

Reference: <https://github.com/IssabelFoundation/framework> and <https://github.com/voipiran/VOIZ>.

## Bundled components

- Bootstrap styles and JavaScript retain their embedded copyright and license notices.
- jQuery Validation, GSAP, Joinable, Neon assets, and other legacy libraries retain their existing
  source headers and applicable original terms.
- Glyphicons font assets and generic framework images are included as existing framework
  dependencies; their original attribution and terms continue to apply.
- **Vazirmatn font** (`framework/html/themes/akzfa/fonts/vazirmatn/*.woff2`):
  Copyright 2015 The Vazirmatn Project Authors (<https://github.com/rastikerdar/vazirmatn>),
  licensed under the SIL Open Font License 1.1 — see `LICENSES/Vazirmatn/OFL-1.1.txt`.
- Tailwind CSS is a development dependency, pinned by `package-lock.json`; its package contains its
  own license. Development dependencies are not bundled with the server installation.

## Rename map (from the upstream VOIZ presentation layer)

`vitenant→akzfa`, `voiz-*→akzfa-*`, `voiz-theme→akzfa-theme`, `--voiz-*→--akzfa-*`.
Branding strings were replaced with AKZ-only values; the `/etc/akzfa.conf` dependency is guarded
and optional.

## Export provenance

The interface source snapshot used for this package was the `test2` branch of `akzwp/VOIZ`
(redesign layer v7.1.x). No git history or machine-specific configuration is included.
