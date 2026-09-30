# Proposal: Modernize `farsi_rtl` (or add `akzfa`) — Persian UI improvements for the Issabel framework

> **Prepared for:** IssabelFoundation — `framework` repository
> **Related proposal:** `../01-issabel-framework/PROPOSAL.md` (new optional theme `akzfa`)
> **Prepared by:** AKZ (akzwp) — <https://akzwp.com>

---

## 1. Summary

The framework currently ships `farsi_rtl` as its Persian theme. This proposal offers two alternatives
(maintainers choose one):

- **Option A (recommended):** accept the new optional theme `akzfa` (full proposal in
  `../01-issabel-framework/PROPOSAL.md`). `farsi_rtl` stays untouched.
- **Option B:** apply selected AKZ UI improvements to `farsi_rtl` itself — dark/light tokens,
  modernized tables/forms/dialogs, responsive sidebar — as a reviewed patch series.

## 2. What changes would Option B include?

1. Design tokens (`--akzfa-*` CSS variables) and dark/light support behind `data-theme`.
2. Vazirmatn font bundling (OFL-1.1, local files) replacing legacy font stacks.
3. A cascade-last stylesheet so module CSS keeps working untouched.
4. Accessibility fixes: focus states, dialog semantics, aria-labels.
5. Responsive/mobile drawer navigation.

## 3. Risk comparison

| | Option A (new theme) | Option B (patch `farsi_rtl`) |
|---|---|---|
| Risk to existing users | None (opt-in) | Moderate (existing users see changes) |
| Upgrade conflicts | None | Possible on framework updates |
| Review effort | Directory-add + build docs | Full diff review of a shipped theme |

## 4. Validation

Identical to the main proposal: automated build/contrast/DOM checks pass; server-side validation
(Issabel 4/5, screenshots, rollback test) will be attached before the PR is marked ready.
