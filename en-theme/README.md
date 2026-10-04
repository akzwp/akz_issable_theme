# AKZ — English theme for Issabel

AKZ is an English, left-to-right interface for an existing Issabel server. Its installed name is `akz`. It includes light/dark appearance, responsive navigation, module search, and coordinated forms, tables and calendar controls.

**New to server installation? Start with [INSTALL.md](INSTALL.md).** It explains every command, where to run it, and what a successful result looks like. No Node.js, npm or CSS compilation is required on the server.

## 1. Choose your task

| Your situation | Follow this guide |
|---|---|
| You have not installed this edition yet | [First installation](INSTALL.md) |
| AKZ is installed and you want the latest files | [Update an existing installation](UPDATE.md) |
| You want the previously selected theme back | [Uninstall / restore the previous selection](UNINSTALL.md) |
| Installation reports an error or the old appearance remains | [Installation troubleshooting](INSTALL.md#troubleshooting) · [Update troubleshooting](UPDATE.md#troubleshooting) |

## 2. Know where commands run

1. Use your computer only to open an SSH connection or download a package for transfer.
2. Run the Linux installation commands **on the Issabel server**, after connecting to it.
3. Obtain the **complete** English package. Do not copy just `install.sh`, a CSS file or the theme directory.
4. Enter the package directory containing `README.md`, `VERSION`, `install.sh`, `uninstall.sh`, `framework` and `contrib`.
5. Follow the guide for your operation.

The `en` branch extracts as `akz_issable_theme-en`. If you downloaded `main`, enter its `en-theme` folder instead. There is no additional `en-theme` folder inside the English branch package.

## 3. First installation, in order

1. Follow the SSH/root and prerequisite instructions in [steps 1–2 of INSTALL.md](INSTALL.md).
2. Follow the package-download steps in that guide.
3. Read `VERSION`, save the package path and run `bash install.sh` in the root shell.
4. Expect a line beginning `Installed akz, version` and a recovery-directory path.
5. Sign out of Issabel and sign back in, then follow the guide's selection check.

The installer selects AKZ and English automatically. To place the files without selecting the theme, use the separately explained `--no-activate` option.

## 4. Updating, in order

1. Obtain a new package, or update a clean Git checkout as described in [UPDATE.md](UPDATE.md).
2. Run the installer **from that updated package**.
3. Save the displayed version and recovery path.
4. Sign out and back in.

Uninstalling first is unnecessary. Reinstalling from an old download does not fetch GitHub changes. `cat VERSION` describes the downloaded package, not proof of what is currently installed.

## 5. Uninstalling, in order

1. Open [UNINSTALL.md](UNINSTALL.md) and read the saved previous-theme selection.
2. Enter a complete English package directory on the server.
3. Run `bash uninstall.sh` in the root shell.
4. Sign out and back in.

This restores the saved selection only when `akz` is still active. Files and recovery records remain on the server. It does not remove Issabel, delete call data, or replace the current AKZ files with an older version.

## Source, proposals and status

The editable source is [main/en-theme](https://github.com/akzwp/akz_issable_theme/tree/main/en-theme); the `en` branch is the installable export. [Developer instructions](contrib/akz-theme/README.md), [upstream proposal](PULL_REQUEST.md), and [submission notes](PUSH_GUIDE.md) are optional reading for contributors.

No browser, installation or automated tests have been run for these revisions. Runtime compatibility remains for the owner to evaluate.

Retain [LICENSE](LICENSE), original file headers and [third-party notices](contrib/akz-theme/THIRD_PARTY_NOTICES.md). AKZ does not imply endorsement by Issabel or VOIZ.
