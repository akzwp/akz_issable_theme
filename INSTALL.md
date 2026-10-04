# Install the English AKZ theme, step by step

[Start page](README.md) · [Update](UPDATE.md) · [Uninstall](UNINSTALL.md)

This guide installs the English `akz` theme on an **existing Issabel server**. It does not install Issabel itself. Read a step, run its commands in order, and continue only if they succeed. Do not paste the whole guide as one script.

## Before you begin

You need:

- A working Issabel web interface, its address, and your existing web-login credentials.
- SSH access to that server, with the root password or an account allowed to use `sudo`. SSH and web-login credentials may differ.
- The standard Issabel paths shown in step 2, Bash 4+, GNU coreutils/findutils, `flock` and `sqlite3`.
- `curl`, `tar` and internet access on the server for the recommended download method. An offline transfer alternative is included below.
- Free disk space for the package and recovery copies of any existing AKZ deployment. Each update keeps backups; it does not prune them.

Node.js, npm and Git are not installation requirements. The installer does not download system dependencies. Its recovery copies cover the theme and selection metadata, not a full PBX backup.

## 1. Connect to the server and obtain a root shell

On your computer, open a terminal. Windows users can use PowerShell or Windows Terminal if SSH is available; an existing SSH client also works.

Replace `SSH_USER` with your server login and `SERVER_IP` with the server's address. Do not type the placeholder words literally:

~~~sh
ssh SSH_USER@SERVER_IP
~~~

For a non-default SSH port, use `ssh -p PORT SSH_USER@SERVER_IP` with the actual port. On a first connection, confirm the server identity against the fingerprint provided by your administrator. Enter the SSH password if requested; the terminal normally shows no characters while you type it.

Once connected, if you did not log in as root, run:

~~~sh
sudo -i
~~~

Enter your account's sudo password if requested. If sudo is unavailable or denied, use the root access supplied by the server administrator. These login prompts are separate from the unattended installer.

Confirm the shell is root:

~~~sh
id -u
~~~

The result must be `0`. **All remaining shell commands in this guide run on the server in this root shell.**

## 2. Confirm this is an existing standard Issabel installation

Run:

~~~sh
bash --version
ls -ld /var/www/html/index.php /var/www/html/themes/tenant /var/www/db/settings.db
~~~

Bash must be version 4 or later, and all three paths must exist. If a path is missing, stop; do not create a replacement database or an empty tenant directory.

To see the currently selected theme and language, use this read-only query. The file check prevents SQLite from creating an empty database if the expected file is absent:

~~~sh
test -f /var/www/db/settings.db && sqlite3 -separator ' = ' /var/www/db/settings.db "SELECT key,value FROM settings WHERE key IN ('theme','language') ORDER BY key;"
~~~

Expect two rows, such as `language = en` and `theme = tenant`; your existing values may differ. Save them in your notes. If the command fails or the rows are missing, resolve that problem before installation.

<a id="download"></a>
## 3. Download a complete, fresh English package

Use this method for both a first installation and an archive-based update. Every execution creates a new download directory, so it does not overwrite a previous package.

Create and enter the directory:

~~~sh
mkdir -p "$HOME/akz-downloads"
akz_download=$(mktemp -d "$HOME/akz-downloads/en-XXXXXXXX")
cd "$akz_download"
~~~

Download the English branch archive:

~~~sh
curl --fail --location --proto '=https' --tlsv1.2 --output akz-en.tar.gz https://github.com/akzwp/akz_issable_theme/archive/refs/heads/en.tar.gz
~~~

If downloading fails, stop and resolve the connection or tool error; do not try to extract a partial download. Then extract and enter the package:

~~~sh
tar -xzf akz-en.tar.gz
cd akz_issable_theme-en
~~~

The archive contains the current `en` branch. It may change when new work is published. Keep the downloaded archive if you need the exact same package again.

### Alternative: transfer a package from your computer

Use this only if you cannot download directly on the server:

1. On your computer, download the [English TAR.GZ archive](https://github.com/akzwp/akz_issable_theme/archive/refs/heads/en.tar.gz).
2. Open your existing SFTP client and connect to the same server with your SSH credentials.
3. Upload the complete archive to a directory writable by that SSH account. Note the full remote path.
4. In the server's root shell, run the three directory-creation commands at the start of step 3.
5. Extract the uploaded file with `tar -xzf "/FULL/REMOTE/PATH/akz_issable_theme-en.tar.gz"`, replacing the path and filename with the actual uploaded file.
6. Run `cd akz_issable_theme-en`, then continue with step 4.

If you used GitHub's ZIP download instead, extract the ZIP into a new local folder and transfer the **whole extracted folder**, including its subfolders, by SFTP. Enter that uploaded folder on the server. Do not run `tar` on a ZIP file, and do not upload the archive into the public web directory.

## 4. Confirm the package and save its location

Run:

~~~sh
pwd
ls README.md VERSION install.sh uninstall.sh framework contrib
cat VERSION
~~~

All listed items must exist. Save the path printed by `pwd`; you will use it for updates or uninstallation. The `VERSION` value belongs to this downloaded package. At the time of this guide, the English package reports `2.0.0`; later releases may report a newer value.

If you downloaded `main` instead of `en`, enter `en-theme` inside `akz_issable_theme-main` before running these commands. Do not enter `en-theme` when you are already in the English branch package.

## 5. Install and select the English theme

From that package directory, run:

~~~sh
bash install.sh
~~~

No installer questions, Node.js, npm, CSS build, service restart or reboot are required. This default command installs the files and selects `akz` with language `en`.

Wait for completion. A successful run prints a line with this format; the backup suffix varies:

~~~text
Installed akz, version 2.0.0. Recovery files: /var/lib/issabel/akz-theme/backup-...
Theme and language selected. Sign out and sign in again.
~~~

Compare the printed version to step 4 and save the **full actual recovery path**. If an error appears, use the troubleshooting section; do not assume installation completed.

### Optional: install files without selecting the theme

Only if you deliberately want to keep the current selection, use this command **instead of** the default command:

~~~sh
bash install.sh --no-activate
~~~

An already active AKZ theme will still receive the updated files. This option preserves selection; it does not hide an update to an active theme. For a first inactive installation, it does not create a previous-selection record.

To select AKZ later, return to the same package directory and run `bash install.sh` without the option.

## 6. Open the installed theme

1. Return to the Issabel web address you used before installation.
2. Sign out, then sign back in with your existing Issabel account.
3. The selected theme should be English AKZ, unless you used `--no-activate`.
4. If the old appearance remains, reload with Ctrl+F5 on Windows/Linux, or use a private browser window.
5. Repeat the read-only settings query from step 2. A normal active installation should show `language = en` and `theme = akz`.

The query confirms the selected settings, not visual compatibility of every module. Keep the package and recovery-path notes. [UPDATE.md](UPDATE.md) explains later updates; [UNINSTALL.md](UNINSTALL.md) explains returning to the previous selection.

<a id="troubleshooting"></a>
## If a step fails

| Message or symptom | What to do next |
|---|---|
| `Run as root.` | Repeat step 1; `id -u` must print `0`. |
| `install.sh: No such file or directory` or missing `VERSION` | Use `pwd` and `ls`. Enter the extracted English package, or `en-theme` inside main. Keep `framework` and `contrib` together. |
| `curl` or `tar: command not found` | Use the transfer alternative, or have the administrator install the missing tool from the server's configured trusted repositories. |
| Download or certificate error | Check server time and connectivity with the administrator. Retry the download after correction; do not disable certificate verification. |
| `Required Issabel system command is missing:` | The message names the tool. Have the administrator provide it using the server's supported repositories, then retry. |
| `An existing standard Issabel installation with tenant is required.` | Check step 2. This installer does not set up Issabel or support arbitrary custom paths. |
| `An unmanaged theme directory already exists` | An `akz` directory exists without this installer's ownership record. Stop and ask the administrator to review its origin and back it up; do not delete it or fabricate a `managed` marker. |
| `Another AKZ theme operation is running.` | Wait for that operation to finish. Do not remove its lock to bypass the message. |
| Unsafe state, symbolic-link path, unexpected setting, or missing recovery-record error | Keep the exact error. Have the administrator review the named path or settings; do not apply recursive permission changes or edit the database by guesswork. |
| `Installation failed; recovery files:` | Save the complete output and both printed paths. Recovery was attempted; ask the administrator to inspect the result before retrying. |
| Installation succeeded but the old UI remains | Follow [UPDATE.md's ordered checks](UPDATE.md#troubleshooting). |

If requesting help, provide the edition, package version, command you ran and exact error. Do not share passwords, SIP credentials or database contents.

## What the installer changes and retains

| Server location or setting | Purpose |
|---|---|
| `/var/www/html/themes/akz` | The deployed English theme files |
| `/var/lib/issabel/akz-theme` | Private management records and `backup-*` recovery directories |
| `/var/lib/issabel/akz-themes` | Shared lock for the English and Persian installers |
| `theme` and `language` rows in `/var/www/db/settings.db` | Selected theme and language, updated in one guarded transaction when activation is requested |

The installer replaces the entire managed theme directory. Keep your own theme edits separately before updating. Files are owned by root and readable by the web server; SELinux labels are restored when `restorecon` is available. Source timestamps are refreshed to help Smarty notice changed templates; shared caches and sessions are retained.

Call records, recordings, extensions, users, dialplans, module files and firewall rules are outside this installer's scope. Recovery attempts cover ordinary failures and catchable interruptions. File deployment and the database update are separate operations; power loss or SIGKILL may need manual recovery from the printed paths.

These instructions were checked against the installer source. No browser, server-installation or automated tests were run.
