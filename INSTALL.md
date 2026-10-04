# Installation and recovery

The package is a theme for an **existing** Issabel server. It does not install or upgrade Issabel. Copy or extract a complete language branch on the server, then run:

```sh
sudo bash install.sh
```

This installs and activates that edition and selects its language without prompts, downloads, Node.js, npm, or a build step. Sign out and sign in again to refresh the existing session. A browser may also need a reload for the new assets. The installer prints the package version and refreshes this theme’s file timestamps during deployment; it does not remove shared caches. Reinstalling an old checkout/archive does not download an update: first fetch the current branch or extract a new archive.

```sh
sudo bash install.sh --no-activate  # install files while preserving the selection
sudo bash uninstall.sh            # restore the previous selection when AKZ is active
```

The old `contrib/<theme>-theme/install.sh --activate` entry point remains supported.

## Prerequisites

- Standard paths: `/var/www/html`, `/var/www/html/themes/tenant`, `/var/www/db/settings.db`.
- Root, Bash 4+, GNU coreutils/findutils, util-linux `flock`, and `sqlite3`. These are system tools; Issabel's framework RPM explicitly requires coreutils and sqlite. Missing prerequisites cause an error before theme deployment. The installer does not change repositories or install unrelated packages.
- Persian activation additionally requires the installed `/var/www/html/lang/fa.lang`. The theme does not supply translations for every third-party module or install a Jalali calendar engine.

## Changes made on the server

Only `/var/www/html/themes/akz` or `akzfa`, private state under `/var/lib/issabel/<theme>-theme`, and the shared lock under `/var/lib/issabel/akz-themes` are managed. Activation updates exactly the `theme` and `language` rows in one SQLite transaction. It never replaces the database file, clears caches, restarts services, changes ownership of the database, or touches call records, users, dialplans, recordings, firewall rules or module files. Theme files are root-owned and readable by the web server. SELinux labels are restored at the final destination when restorecon is available.

Both editions share a lock. The installer rejects symbolic-link destinations, special files in the package, unmanaged theme directories, unsafe state ownership, and unexpected settings. It stages the package, saves the previous deployment and settings, and attempts recovery on ordinary errors and catchable interruption. A database guard rejects activation if the theme/language selection changed during preparation.

Each upgrade retains a private `backup-*` directory. Automatic rollback does **not** promise crash consistency for power loss or SIGKILL: file replacement and SQLite commit cannot form one atomic transaction. In that case inspect the printed recovery paths before repeating installation. Backups consume space and are not automatically pruned.

## Recovery semantics

The saved selection is captured when activating from a different theme, not during an inactive file-only install. Repeat installation while active retains that recovery record. Records from the old AKZ installer are imported as validated values; saved SQL is never executed.

Uninstall restores the saved theme only when this edition is still selected. It restores the saved language only if the current language still equals the language selected by the installer. Later administrative choices are preserved. **Theme files and recovery records remain installed**: the other edition may need them for its own rollback. This command deactivates the theme; it is not a destructive purge. If the saved theme directory is missing, it exits without changing settings.

The Persian package no longer distributes its inherited phone backend. A separately installed webphone remains owned by that application. Upgrading AKZ replaces the whole managed theme directory, so previously bundled phone files are removed from the served directory and retained only in private backups.

## Reproducibility and status

Use a reviewed commit or release archive and retain its commit ID. The prebuilt CSS is distributed with the editable sources; no network access is needed during installation. Optional developer build instructions are in `contrib/`. Source review and CSS generation were performed for this revision. **No browser, installation, unit, integration, automated, security, or compatibility tests were run.** Server compatibility and visual equivalence remain unverified.
