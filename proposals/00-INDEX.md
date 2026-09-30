# Index — Upstream proposals

| # | Proposal | Target repository | Goal |
|---|---|---|---|
| 1 | [`01-issabel-framework`](01-issabel-framework/PROPOSAL.md) | `IssabelFoundation/framework` | Add optional Persian theme `akzfa` |
| 2 | [`02-voiz-upstream`](02-voiz-upstream/PROPOSAL.md) | `voipiran/VOIZ` | Replace `vitenant` theme with the AKZ UI layer v7 |
| 3 | [`03-issabel-farsi-rtl`](03-issabel-farsi-rtl/PROPOSAL.md) | `IssabelFoundation/framework` | Alternative: modernize shipped `farsi_rtl` |

## Submission checklist (per proposal)

1. Open a **draft PR** from a fork (not from this repository) — see `ROADMAP.md` for the fork flow.
2. Link the proposal document in the PR description (Persian or English as the repo requires).
3. Attach screenshots (login, dashboard, CDR, reports, PBX config, calendar) and the environment
   matrix (Issabel 4/5, browser versions) **after** running the test checklist in
   `fa-theme/COMPATIBILITY.md`.
4. Wait for maintainer feedback on naming/scope **before** requesting a full review.
5. Keep CI/authorship clean: no unrelated commits, no history rewrites, sign-off on DCO if required.
