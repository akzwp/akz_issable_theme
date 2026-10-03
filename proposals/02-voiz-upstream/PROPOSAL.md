# Proposal: replace the VOIZ Persian theme with AKZ

## Problem and proposed result

The AKZ redesign gives the VOIZ Persian interface a consistent RTL layout, local Vazirmatn typography, light/dark appearance, responsive navigation, module search and aligned forms, tables and calendar dialogs. This proposal requests adoption as VOIZ's default presentation after maintainer review and the owner's server evaluation.

The theme source is derived from local `theme/vitenant` and `ui` in the author's VOIZ checkout. The standalone `akzfa` package now includes the newer control and calendar fixes that were missing from the GitHub export.

## Integration map

| AKZ source | Suggested VOIZ destination | Purpose |
|---|---|---|
| `fa-theme/framework/html/themes/akzfa/` | `theme/akzfa/` | Runtime templates, CSS, JavaScript and local assets |
| `fa-theme/contrib/akzfa-theme/ui/` | `contrib/akzfa-theme/ui/` | Editable style sources |
| `fa-theme/contrib/akzfa-theme/LICENSES/` and notices | Matching contribution directory | Attribution and component license texts |

Retaining the `akzfa` directory and selector namespace makes the package usable unchanged on Issabel and VOIZ. If maintainers require the existing directory name `vitenant`, adapt the **filesystem paths** and deployment selection together; do not blindly rename every CSS selector, storage key and JavaScript identifier. The new standalone installer deliberately does not overwrite an unmanaged vitenant directory.

## Exact scope

- `_common/*.tpl`: shell and login markup, theme switching, navigation/search controls and final stylesheet loading. Framework content slots and form processing remain in place. Dynamic displayed login names are escaped.
- `css/akzfa-tailwind.css` and `contrib/.../ui/*.css`: design tokens, RTL shell, form controls, table overflow, dialog positioning and calendar color selection. Sources and generated CSS are committed together.
- `js/akzfa-ui.js`, `js/akzfa-embedded.js`: presentation behavior and same-origin embedded PBX styling. Module data and authorization remain host responsibilities.
- `themesetup.php`: existing framework hook plus a package-local version; no /etc branding-config requirement. This is a PHP file change, so the contribution must not be described as containing no PHP changes.
- Inherited theme-local phone files are excluded because the backend trusted a client cookie to retrieve SIP credentials. The contribution does not replace VOIZ's separately installed webphone.

No whole-module templates, SQL databases, sound packs, custom dialplans, Asterisk patches or bundled application installers are part of this package. The theme styles existing calendar support; it does not implement a Jalali calendar engine or translate all third-party applications.

## Integration steps

1. Create a contribution branch in a fork of [voipiran/VOIZ](https://github.com/voipiran/VOIZ), starting from the target release. Inspection baseline: `efad478796d10772c16ec450dd233ebf09eb5c5c` (main). Copy only the paths above.
2. Adapt the theme deployment stage in [install.sh](https://github.com/voipiran/VOIZ/blob/efad478796d10772c16ec450dd233ebf09eb5c5c/install.sh). At this baseline, `add_vitenant_theme()` copies `theme/vitenant` and selects vitenant in settings.db. Replace that stage with deployment of `theme/akzfa` and selection of akzfa, including a saved previous selection and file backup. Retain the tenant fallback. Do not change unrelated installer stages.
3. For already installed systems, distribute the standalone `fa` branch: `sudo bash install.sh` installs only the theme and activates Persian. **Do not rerun the full VOIZ installer merely to update a theme.** The standalone script requires the standard Issabel paths and existing Persian language pack.
4. Preserve upstream branding and copyright attribution where VOIZ requires it. Align asset URLs, template IDs and the chosen namespace as one change. Include generated CSS; no Node.js/npm or build process belongs in the server installation path.
5. Open a draft PR with the actual target-repository diff and this proposal. Attach the owner's target-release results before requesting default replacement. Keep the previous theme available for rollback during migration.

## Data integrity and readiness

The standalone installer uses root-owned assets, private backups, symlink rejection, a shared lock and a guarded SQLite transaction updating only theme/language. Deactivation restores the saved selection when appropriate and retains files so the sibling edition can still restore them. It does not promise atomic recovery after power loss or SIGKILL.

**No tests were run for this revision.** Source review and CSS generation do not establish browser compatibility, accessibility conformance, performance or security certification. Owner/maintainer evaluation of login, module forms, calendar behavior, RTL layout, theme switching and install/upgrade/recovery remains pending. The decision to change VOIZ defaults belongs to its maintainers.
