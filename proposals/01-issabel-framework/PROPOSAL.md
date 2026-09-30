# Proposal: Add `akzfa` — an optional Persian (RTL) theme for the Issabel web framework

> **Prepared for:** IssabelFoundation — `framework` repository (theme layer)
> **Prepared by:** AKZ (akzwp) — <https://akzwp.com>
> **Status:** Draft for maintainer feedback. Not yet tested on a production server (see Validation).
> **License of the contribution:** GPL-2.0-or-later (matching the framework). Bundled Vazirmatn font: SIL OFL 1.1.

---

## 1. Summary

This proposal adds an **optional, self-contained theme directory** named `akzfa` under
`framework/html/themes/`, providing a professional **Persian / right-to-left** interface for Issabel:

- Full RTL layout with the locally-bundled **Vazirmatn** font (8 weights, OFL-licensed, no CDN).
- Dark/light appearance switch (CSS variables, no flash of wrong theme on load).
- Responsive sidebar with live module search; mobile drawer.
- Styled dialogs, tables, forms, notifications; Gregorian **and** Jalali calendar styling.
- Zero changes to framework core, module backends, authentication, menu authorization, or PBX logic.

A matching **English/LTR edition** (`akz`) is developed in the same codebase and can be submitted as a
separate, parallel proposal.

## 2. Why an optional theme (and not edits to `tenant` or `farsi_rtl`)

| Approach | Risk | Upgrade path |
|---|---|---|
| Edit `tenant` in place | Breaks existing installs; conflicts on every framework update | Painful |
| Patch core CSS/JS | High regression risk across modules | Painful |
| **Add a new theme directory (proposed)** | None for existing users — opt-in only | Trivial: replace one directory |

This mirrors how the project already ships multiple themes (`tenant`, `farsi_rtl`) and how the
community distributes extra themes (e.g. the `powerpbx/issabel-themes` collection).

## 3. Technical design

- **Selection mechanism:** unchanged — the `theme` key in `/var/www/db/settings.db` selects
  `/var/www/html/themes/akzfa`; the standard `themesetup.php` hook performs Smarty assignments
  (menu icons, breadcrumbs, notifications) exactly like the stock themes.
- **Cascade strategy:** base CSS (Bootstrap, Neon) loads first, then `{$HEADER}`/`$HEADER_MODULES`
  (module CSS), and the redesign layer `css/akzfa-tailwind.css` loads **last**, so it wins the
  cascade without `!important` wars or touching module files.
- **Tailwind is build-time only:** `corePlugins.preflight: false` to preserve legacy widgets;
  generated utilities carry a `tw-` prefix to avoid collisions. Compiled CSS ships with the theme;
  the server never needs Node.js.
- **Design tokens:** CSS custom properties prefixed `--akzfa-*`, defined on `:root` and
  `[data-theme="light"|"dark"]`.
- **Embedded pages** (Asternic, FOP2, phone) are styled via an embedded layer while shown inside the
  theme; their application files are not modified.
- **No runtime dependencies** beyond what Issabel already ships.

## 4. Provenance and licensing

- Templates and `themesetup.php` derive from the Issabel framework (GPLv2+ file headers preserved).
- The redesign layer originates from the author's UI work on the `voipiran/VOIZ` Persian
  distribution (MIT for its added parts, GPL for framework-derived parts) and is contributed here
  under **GPL-2.0-or-later** to match the framework.
- The **Vazirmatn** font is bundled under the **SIL Open Font License 1.1** with its license text
  included; font files are served locally (no external requests).
- "AKZ" identifies the interface contribution; it is not a claim of ownership or endorsement.

## 5. Packaging

Two options — maintainers' preference requested:

1. **Theme directory only** (`framework/html/themes/akzfa/`) merged like any other theme.
2. **Theme + `contrib/` packaging** (as prepared in the referenced repository): editable CSS sources,
   pinned Tailwind build, `install.sh`/`uninstall.sh` with atomic staging, `flock` locking,
   settings backup/restore under `/var/lib/issabel/akzfa-theme`, and full license documents.

## 6. Validation status (honest disclosure)

- Compiled CSS passes automated build/contrast/DOM checks (jsdom-based) in the source repository.
- **No browser, installation, application, automated, or compatibility tests have been run against a
  real Issabel server yet.** Before marking this PR ready for review, the author will provide:
  - Issabel 4 (Asterisk 16) and Issabel 5 (Asterisk 18) installation results,
  - before/after screenshots (login, dashboard, CDR, reports, PBX config, calendar),
  - rollback verification (`uninstall.sh` restores prior `theme`/`language`).

## 7. Maintainer decisions requested

- Preferred theme name (`akzfa` or otherwise) and whether the English sibling (`akz`) should follow.
- Theme-directory-only vs. `contrib/` packaging scope (Section 5).
- Whether the Jalali calendar assets should remain inside the theme or move to a language pack.
- RPM/release packaging implications for shipping an additional theme.
