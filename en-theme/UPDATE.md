# Update the English AKZ theme, step by step

[Start page](README.md) · [First installation](INSTALL.md) · [Uninstall](UNINSTALL.md)

Updating has **two separate parts**: obtain the new package, then run its installer. Reinstalling an old folder does not contact GitHub. Downloading a new package alone does not change the theme running on your server.

You do not need to uninstall first. The installer keeps the previous deployment in private recovery files and, when AKZ is already active, retains the original previous-theme selection.

## 1. Prepare the server session

1. Follow [INSTALL.md, steps 1–2](INSTALL.md), to connect to the correct server, obtain a root shell, and read the current theme/language.
2. Choose the English package if you are updating `akz`. Updating `fa` installs a different theme, `akzfa`.
3. Save any personal modifications to the deployed theme separately. Deployment replaces the whole managed `/var/www/html/themes/akz` directory.
4. Keep the old package and your previous recovery-path notes. Choose **one** download method below.

## 2A. Recommended: download a new archive

Run each block in the server root shell and stop if it fails. First create a new directory:

~~~sh
mkdir -p "$HOME/akz-downloads"
akz_download=$(mktemp -d "$HOME/akz-downloads/en-XXXXXXXX")
cd "$akz_download"
~~~

Download the current English archive:

~~~sh
curl --fail --location --proto '=https' --tlsv1.2 --output akz-en.tar.gz https://github.com/akzwp/akz_issable_theme/archive/refs/heads/en.tar.gz
~~~

After a successful download, extract it and enter the new package:

~~~sh
tar -xzf akz-en.tar.gz
cd akz_issable_theme-en
~~~

Do not extract over your old package or mix files from the two directories. If the server cannot download directly, use the [transfer alternative in INSTALL.md](INSTALL.md#download). Then read the new package location and version:

~~~sh
pwd
cat VERSION
~~~

Save the new package path and expected version. Proceed to step 3 below. If this is a documentation-only update, the theme version may be unchanged.

## 2B. Alternative: update an existing Git checkout

Use this only if the English package was obtained with `git clone`. Extracted ZIP and TAR.GZ archives are **not** Git checkouts. Git must already be available.

Enter your existing checkout, replacing the path with the one on your server:

~~~sh
cd "/FULL/PATH/TO/YOUR/EN-CHECKOUT"
git remote get-url origin
git branch --show-current
git status --short
~~~

Before continuing:

1. The remote must refer to `akzwp/akz_issable_theme`, for example `https://github.com/akzwp/akz_issable_theme.git`.
2. The current branch must be `en`.
3. The status command should print nothing. If it lists changed or untracked files, stop and preserve your work before updating. Do not use a hard reset or delete files to silence it.
4. If you have `main`, another branch, an older Git without `--show-current`, or an ownership warning, use the fresh-archive method instead of changing Git configuration by guesswork.

Then run:

~~~sh
git pull --ff-only origin en
~~~

Continue only if it succeeds. If Git reports divergent history, do not force the update; preserve the checkout and use a fresh archive.

Record the downloaded source revision and version:

~~~sh
git rev-parse HEAD
cat VERSION
~~~

`Already up to date` means the checkout already contains the remote changes. It does not prove those files were installed on the server.

## 3. Deploy the downloaded update

You must be inside the **new archive's package directory** or the **updated English checkout**. Confirm the contents:

~~~sh
ls VERSION install.sh framework contrib
~~~

To deploy and select English AKZ:

~~~sh
bash install.sh
~~~

If another theme is selected and you only want to update AKZ's files while preserving that selection, use `bash install.sh --no-activate` **instead**. When AKZ is already active, this option still updates the visible theme.

Wait for the `Installed akz, version ... Recovery files: ...` line. Compare the version to step 2 and save the actual recovery path. An error must be resolved before treating the update as complete.

## 4. Refresh the browser session

1. Sign out of the Issabel web interface.
2. Sign back in at the same address.
3. Reload with Ctrl+F5 on Windows/Linux, or use a private browser window if the old appearance remains.
4. Repeat the read-only selection query in [INSTALL.md, step 2](INSTALL.md). A normal activated English installation selects `akz` and `en`.

No reboot or manual shared-cache deletion is part of this update procedure.

<a id="troubleshooting"></a>
## 5. If the old theme still appears

Check in this order:

1. **Package:** did you actually download new files? `cat VERSION` in an old folder only describes the old download.
2. **Directory:** did you run the installer from the new package? Use `pwd` and compare it to the path saved in step 2.
3. **Completion:** did installation reach the success line, and did its version match the package? A download alone is not deployment.
4. **Selection:** does the query show `theme = akz`? `--no-activate` intentionally preserves the previous choice.
5. **Session:** did you sign out and back in and try a fresh browser page?
6. **Server:** are the browser address and SSH destination the same Issabel server? If a reverse proxy caches assets, ask its administrator to inspect the relevant theme files.
7. **Module differences:** stock Issabel and VOIZ may render different module templates. A local preview with sample data does not establish that every live module has the same markup.

When reporting a remaining issue, include the package version, Git commit if available, installer completion/error text, and the affected module. Do not upload databases or credentials.

## 6. If you want to go back

For a quick return to the previously selected theme, follow [UNINSTALL.md](UNINSTALL.md). That changes selection; it does not put an older AKZ file version back.

To restore a particular older AKZ version, an administrator must identify and review the appropriate old package or private deployment backup. Do not copy a whole settings database from a backup. A failed deployment or power interruption may need recovery from the exact paths printed by the installer.

No installation or browser tests were run while preparing this guide.
