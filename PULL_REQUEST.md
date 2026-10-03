# Proposal: adopt AKZ English and Persian themes in Issabel

## Problem and proposed result

AKZ provides a consistent interface for English/LTR and Persian/RTL users: responsive navigation, searchable modules, light/dark appearance, readable forms and tables, and improved calendar dialogs. The requested destination is to replace the default English and Persian presentation with AKZ, subject to maintainer review and the owner's server evaluation.

The implementation first introduces separate `akz` and `akzfa` directories so adoption and rollback remain explicit. Changing defaults for new installations and migrating existing installations should be separate, reviewable release decisions. No automatic fleet-wide migration is included in this contribution.

## Concrete code changes

| Source in AKZ main | Destination in framework | Effect |
|---|---|---|
| `en-theme/framework/html/themes/akz/` | `framework/html/themes/akz/` | English shell, templates, compiled CSS and interaction scripts |
| `fa-theme/framework/html/themes/akzfa/` | `framework/html/themes/akzfa/` | Persian RTL shell and local Vazirmatn fonts |
| Both `contrib/` directories | `contrib/akz-theme/`, `contrib/akzfa-theme/` | Editable styles, optional developer builds, installation/recovery tools and notices |

The theme hook `themesetup.php` keeps the existing Smarty assignments and menu/notification integration. Its package version is local; it no longer reads a distribution-specific /etc branding file. `_common/*.tpl` retain the framework content slots, login field names and module requests. Displayed login names are HTML-escaped. Base CSS loads before framework and module headers; the AKZ stylesheet loads after them.

The CSS sources define colors, spacing, navigation, forms, switches, radios, table overflow and dialog layout. The current revision restores local calendar sizing/close-button fixes and named keyboard-operable color swatches, corrects English dialog centering and English color labels, and aligns selectors with each edition's namespace. Compiled CSS is committed. Tailwind is optional authoring tooling and never runs on a PBX.

The UI scripts add client-side navigation and presentation behavior. Same-origin embedded PBX documents receive the theme layer while displayed in the shell; cross-origin pages are left to their application. This still requires module compatibility evaluation. The Persian package does not distribute the inherited cookie-based SIP-credential/webphone backend. Existing telephony applications stay separate.

## Integration steps

1. Create a contribution branch in a fork of [IssabelFoundation/framework](https://github.com/IssabelFoundation/framework), based on the target release. Inspection baseline: `8f0a6f3045cf1608d294036b77aa5e0f3c66cabc` (master). Copy the paths above; do not replace the repository with the standalone AKZ branch.
2. Preserve upstream copyright headers and the attached license/notices. Reconcile the theme hook and template slots with that exact framework release. Keep authentication, ACL handling and module backends in the host framework.
3. Update [issabel-framework.spec](https://github.com/IssabelFoundation/framework/blob/8f0a6f3045cf1608d294036b77aa5e0f3c66cabc/issabel-framework.spec): its main file list explicitly includes `/var/www/html/themes/tenant`, while themes-extra uses `themes/*` and excludes tenant. To ship AKZ in the main RPM, add both AKZ directories to the main file list and exclude both from themes-extra to avoid duplicate ownership. Verify the build's source-copy rules include both directories.
4. After the owner's results are available, agree on new-install defaults for English and Persian in the release's provisioning/settings path. For existing systems, offer an explicit migration that changes only the theme/language selection and records the previous selection; retain the old themes for rollback. Do not overwrite settings.db or reuse a whole-PBX installer for this operation.
5. Open a draft PR with the actual diff, source commit, tested environment information when available, and this proposal. The standalone theme repository is not a fork of framework, so its language branches cannot directly serve as upstream PR heads.

## Security and data boundaries

The standalone installer stages and backs up managed theme files, uses one lock for both editions, rejects unsafe paths, and updates only theme/language through a guarded SQLite transaction. Recovery preserves later administrative selections. Theme files and recovery records remain after deactivation so either edition can still be restored. Filesystem deployment and database changes are not a crash-atomic transaction. RPM integration should follow the framework's own ownership and packaging conventions.

There are no intended changes to dialplans, accounts, call records, SIP credentials, recordings, services, firewalls or database schemas. A UI contribution is not evidence of complete application security or standards compliance.

## Evidence and readiness

Source comparison and CSS generation were performed. **No tests were run for this revision**, as requested by the owner; no passing tests, measured accessibility scores or supported Issabel-version matrix are claimed. Before default adoption, the owner/maintainers need to supply results for login/logout and permissions, representative module forms and tables, calendar behavior, RTL/LTR layouts, keyboard operation, and installation/upgrade/recovery on their target release. These are pending acceptance criteria, not completed validation.

Please review the directory names, release packaging, default-selection policy and migration timing.

For VOIZ, see the [separate proposal](https://github.com/akzwp/akz_issable_theme/blob/main/proposals/02-voiz-upstream/PROPOSAL.md).
