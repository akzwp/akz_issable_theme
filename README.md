# AKZ themes for Issabel and VOIZ

AKZ changes the appearance of an **existing Issabel/VOIZ server**. It provides English/LTR and Persian/RTL interfaces, light and dark appearance, responsive navigation, and coordinated forms, tables and calendar controls. It does not install the telephone system itself.

**Start with the guide for your language.** The installation package already contains the finished CSS and JavaScript. You do not need Node.js, npm, Git or a build step to install an archive.

## 1. Choose a language

| What you want | Package branch | Theme name on the server | Beginner guides |
|---|---|---|---|
| English, left to right | [en](https://github.com/akzwp/akz_issable_theme/tree/en) | `akz` | [Start here](en-theme/README.md) · [Install](en-theme/INSTALL.md) · [Update](en-theme/UPDATE.md) · [Uninstall](en-theme/UNINSTALL.md) |
| فارسی، راست‌چین | [fa](https://github.com/akzwp/akz_issable_theme/tree/fa) | `akzfa` | [از اینجا شروع کنید](fa-theme/README.md) · [نصب](fa-theme/INSTALL.md) · [به‌روزرسانی](fa-theme/UPDATE.md) · [حذف و بازگردانی](fa-theme/UNINSTALL.md) |

برای نصب فارسی، [راهنمای گام‌به‌گام فارسی](fa-theme/INSTALL.md) را باز کنید. همهٔ فرمان‌های نصب روی سرور ایزابل اجرا می‌شوند؛ پوشهٔ دانلودشده روی رایانهٔ شخصی به‌تنهایی چیزی روی سرور نصب نمی‌کند. برای ارتقا ابتدا بستهٔ جدید را بگیرید و [راهنمای به‌روزرسانی](fa-theme/UPDATE.md) را دنبال کنید.

## 2. Understand branches and folders

A **branch** is a version of the repository selected on GitHub. A **folder** is a directory inside the downloaded package. They are different:

| Download | Directory after extraction | Where the language installer is |
|---|---|---|
| `en` branch | `akz_issable_theme-en` | `install.sh` at that directory's top level |
| `fa` branch | `akz_issable_theme-fa` | `install.sh` at that directory's top level |
| `main` branch | `akz_issable_theme-main` | `en-theme/install.sh` and `fa-theme/install.sh` |

On `main`, the folders are named **`en-theme` and `fa-theme`**, not `en` and `fa`. The language branches contain the contents of the matching folder directly at their root. Beginners should download one language branch and follow its guide.

## 3. Install for the first time

1. Make sure Issabel is already installed and you can sign in to its web interface.
2. Have the server address and an SSH account with root access available. Your Issabel web-login credentials may differ from your SSH credentials.
3. Open [English installation](en-theme/INSTALL.md) or [نصب فارسی](fa-theme/INSTALL.md).
4. Follow its numbered steps to connect to the server, obtain the complete package, enter the correct directory, and run the installer.
5. Compare the printed version with the package's `VERSION` file. Save the recovery path printed by the installer.
6. Sign out of the Issabel web interface and sign in again.

The guides include complete download commands and expected results. The installer selects the edition and its language automatically unless you explicitly choose `--no-activate`. Downloading the archive needs internet access; running the installer after download does not.

## 4. Update an installed theme

1. Follow [English update](en-theme/UPDATE.md) or [به‌روزرسانی فارسی](fa-theme/UPDATE.md).
2. Obtain a **new** archive in a separate directory, or update an existing Git checkout using the documented Git procedure.
3. Read the new package's `VERSION` and run its installer.
4. Save the completion message and recovery path, then sign out and back in.

**Running the installer again from an old folder installs the old files again.** Downloading new files also does not deploy them until you run the new installer. You do not need to uninstall before an update. Updating while the theme is active keeps the original previous-theme selection for uninstallation.

## 5. Uninstall and return to the previous theme

1. Follow [English uninstallation](en-theme/UNINSTALL.md) or [حذف و بازگردانی فارسی](fa-theme/UNINSTALL.md).
2. Use the package for the edition you want to deactivate.
3. Read the saved previous-theme selection, then run that package's `uninstall.sh`.
4. Sign out and back in to see the restored theme.

Here, **uninstall means restoring the previous selection**. Theme files and private recovery records are retained. It does not erase the telephone system or restore an older AKZ file version. If both editions were installed, the previous selection may be the other AKZ edition; the guides explain this case.

## 6. If you already downloaded main

Use the connection and prerequisite steps from the relevant installation guide, then enter the extracted `main` directory on the server. The following commands assume a root shell, as explained in those guides.

For English:

~~~sh
cd en-theme
cat VERSION
bash install.sh
~~~

For Persian, start from the extracted `main` directory instead:

~~~sh
cd fa-theme
cat VERSION
bash install.sh
~~~

Do **not** run these two examples consecutively to install one edition. Choose one. Once inside the chosen folder, its update and uninstall guides apply normally.

Alternatively, the wrapper at the top of `main` accepts the language explicitly:

| Operation from the top of main | English | Persian |
|---|---|---|
| Install and select | `bash install.sh en` | `bash install.sh fa` |
| Install files without selecting | `bash install.sh en --no-activate` | `bash install.sh fa --no-activate` |
| Restore previous selection | `bash uninstall.sh en` | `bash uninstall.sh fa` |

Use either the folder method or the wrapper method, not both for the same operation.

## Scope, recovery and current status

The installer manages the selected theme directory, private recovery files, and the `theme`/`language` settings. The installation guides list exact paths and recovery limits. Their troubleshooting sections explain common errors without deleting databases, changing unrelated permissions or clearing shared caches.

The Persian 2.0.1 package restores local icon and calendar styling, improves the network switch, and supports VOIZ's existing module classes. Both installers refresh copied file timestamps and report the package version.

No browser, server-installation or automated tests have been run for these revisions. Source review and CSS generation do not establish server compatibility; the owner handles evaluation.

## Proposals, source maintenance and licenses

These links are for contributors, not required installation steps:

- [Issabel adoption proposal](proposals/01-issabel-framework/PROPOSAL.md)
- [VOIZ adoption proposal](proposals/02-voiz-upstream/PROPOSAL.md)
- [Source maintenance and branch publishing](ROADMAP.md)

The proposal documents are prepared; no upstream pull requests have been opened. Retain the original [license](LICENSE), component notices and file headers. AKZ identifies the interface contribution and does not imply upstream endorsement.
