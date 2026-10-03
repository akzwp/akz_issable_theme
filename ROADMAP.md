# Maintenance and contribution workflow

1. Keep `main/en-theme` and `main/fa-theme` as the authoring source. Runtime paths and the shared `manage.sh` implementation must stay aligned; each edition keeps its own direction, labels and asset namespace.
2. Edit readable sources. When CSS changes, regenerate and commit its distribution file with the source. Node/npm are optional developer tools and never part of server installation.
3. Commit the complete change on main. Export each language directory as the **root tree** of the corresponding `en` or `fa` branch, using the previous branch tip as the commit parent. This retains branch history and supports a normal fast-forward push. Record the source main commit in each export commit message; do not force-push or maintain a second independently edited copy.
4. The owner evaluates the packages on the target Issabel/VOIZ systems. The current revision is untested; do not tag it as validated or claim supported versions without results.
5. For upstream contributions, create a fork of the target project and copy the specific paths listed in [the proposals](proposals/00-INDEX.md). The standalone distribution branches share no upstream framework history and are not directly suitable as upstream PR heads.
6. Open draft PRs with the actual integration diff, proposal, provenance and pending/completed owner results. Default-theme changes and existing-system migration require explicit maintainer decisions.

## Publishing the package branches

The package trees can be exported without checking out or deleting source directories:

```sh
git fetch origin
source_commit=$(git rev-parse main)
for edition in en fa; do
  tree=$(git rev-parse "$source_commit:$edition-theme")
  parent=$(git rev-parse "origin/$edition")
  commit=$(printf 'Export %s package from main %s\n' "$edition" "$source_commit" | git commit-tree "$tree" -p "$parent")
  git update-ref "refs/heads/$edition" "$commit"
done
git push --atomic origin main en fa
```

Run this only with a clean, reviewed main commit and up-to-date remote refs. Push rejection means the remote advanced; fetch and reconcile instead of forcing the update. Release tags and archives should identify reviewed source commits.
