# Uninstall English AKZ and return to the previous theme

[Start page](README.md) · [Install](INSTALL.md) · [Update](UPDATE.md)

In this repository, `uninstall.sh` **restores the previous theme selection**. It keeps AKZ's theme files, private recovery records and backups on disk. There is no automatic full-delete option. This protects recovery, including cases where the Persian edition needs to return to the English edition.

It does not uninstall Issabel, remove call data, or restore an older version of AKZ's files.

## 1. Connect to the server

Follow [INSTALL.md, step 1](INSTALL.md) to connect by SSH and obtain a root shell. Run `id -u`; it must print `0`.

Use the read-only settings query in [INSTALL.md, step 2](INSTALL.md) to note the current `theme` and `language`.

## 2. Read which theme will be restored

Run:

~~~sh
cat /var/lib/issabel/akz-theme/previous-theme
cat /var/lib/issabel/akz-theme/previous-language
~~~

The first value is the saved theme name, for example `tenant`, `vitenant` or `akzfa`; the second is its saved language. The values depend on what was selected before AKZ activation. They are not always `tenant` and `en`.

Do not edit these records to choose a different destination. If they are missing, see step 6. Very old installer records may use `restore-settings.sql` instead; the current script can import recognized values without executing that saved SQL.

## 3. Locate a complete English package

If you retained the download, enter its directory using the path you saved during installation:

~~~sh
cd "/FULL/PATH/TO/akz_issable_theme-en"
ls uninstall.sh contrib
~~~

Replace the placeholder with the actual path. If you used `main`, enter its `en-theme` subfolder.

If the download was deleted, follow [INSTALL.md, step 3](INSTALL.md#download) to obtain a fresh English package. **Skip the installation step.** The uninstall script reads the server's existing recovery records; you do not need to reinstall first.

## 4. Run the uninstaller once

From that English package directory, run:

~~~sh
bash uninstall.sh
~~~

A successful command prints:

~~~text
Previous selection restored if this edition was active. Later language choices were preserved.
Theme files and recovery records are retained so the other edition can still restore them.
~~~

The wording is conditional: it does not mean a different active theme was overwritten. Save any error instead of assuming success.

## 5. Confirm the result

1. Repeat the read-only settings query from the installation guide.
2. If `akz` was selected when you ran uninstall, the theme should now equal the saved previous-theme value.
3. The saved language is restored only if the current language was still `en`. A later administrator language change is preserved.
4. If a different theme was already selected, uninstall leaves that selection alone.
5. Sign out of the Issabel web interface and sign back in.

If you installed English after Persian, English uninstall may return you to `akzfa`. That is expected. To deactivate Persian as well, read its saved destination and follow the [Persian uninstall guide](https://github.com/akzwp/akz_issable_theme/blob/fa/UNINSTALL.md) separately. Do not repeatedly alternate uninstallers without reading their saved destinations: later activations can change those records.

## 6. Handle missing records or errors

| Situation | Meaning and next step |
|---|---|
| `No activation recovery record was found.` after using only `--no-activate` | No previous selection was saved by that inactive installation. If another theme is still selected, there is no activation to undo. Files remain installed. |
| Records are missing although AKZ is active | Stop and ask the administrator to review installation history. The script cannot reliably guess the old selection. |
| `The previous theme is unavailable; current selection was retained.` | The saved destination folder is missing or unsuitable. The script keeps current settings. Have the administrator restore/review that previous theme before retrying. |
| Current theme is not `akz` | With valid recovery records, the script leaves the active theme alone. It can still reject missing/invalid records before reaching that step. |
| Unsafe state, database error or concurrent-operation message | Preserve the exact output and use the [installation troubleshooting guidance](INSTALL.md#troubleshooting). Do not bypass the safeguards. |
| You want the older AKZ appearance, not a different theme | Uninstall does not roll back AKZ files. See [UPDATE.md, step 6](UPDATE.md). |

## 7. Understand the files that remain

- `/var/www/html/themes/akz`: the installed English theme.
- `/var/lib/issabel/akz-theme`: its selection records and deployment backups.
- `/var/lib/issabel/akz-themes`: the lock directory shared by both editions.
- Your downloaded package: a separate copy used to run these scripts.

Deleting a download does not deactivate the installed theme. Deleting the deployed theme or recovery records can break a later restore, so this guide does not provide an automatic purge command. If disk cleanup is necessary, have the administrator first identify the active theme and the saved destinations of both editions.

To use English AKZ again, follow [INSTALL.md](INSTALL.md) with a complete package. The default installer will select it and record the previous selection as appropriate.

No uninstallation or server tests were run while preparing this guide.
