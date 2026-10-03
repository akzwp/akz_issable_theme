#!/usr/bin/env bash
# Shared implementation, identical in both AKZ editions. Requires Bash 4+.
set -euo pipefail
umask 077
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
export LC_ALL=C

die() { printf '%s\n' "$*" >&2; exit 1; }
theme=${1:-}; action=${2:-}; shift 2
case "$theme" in akz) language=en ;; akzfa) language=fa ;; *) die 'Unknown theme.' ;; esac
activate=true
case "${1:-}" in
  --no-activate) activate=false ;;
  --activate|'') ;;
  --help|-h)
    echo 'Usage: sudo bash install.sh [--no-activate] | sudo bash uninstall.sh'
    echo 'Installation selects this edition and language by default; no downloads or builds.'
    exit 0 ;;
  *) die "Unknown option: $1" ;;
esac
[[ $# -le 1 ]] || die 'Too many arguments.'
[[ $action == install || $action == uninstall ]] || die 'Unknown operation.'
[[ $action != uninstall || $# -eq 0 ]] || die 'Uninstall takes no options.'
[[ $EUID -eq 0 ]] || die 'Run as root.'
for cmd in cp mv install stat find sqlite3 flock readlink mktemp chmod chown date sed; do
  command -v "$cmd" >/dev/null || die "Required Issabel system command is missing: $cmd"
done

here=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
package_root=$(cd -- "$here/../.." && pwd -P)
source_dir="$package_root/framework/html/themes/$theme"
themes=/var/www/html/themes
destination="$themes/$theme"
db=/var/www/db/settings.db
state="/var/lib/issabel/$theme-theme"
lock_dir=/var/lib/issabel/akz-themes

# Canonical paths reject symlinks in every ancestor, not just the final name.
for p in "$themes" "$db" "$state" "$lock_dir"; do
  [[ $(readlink -m -- "$p") == "$p" ]] || die "Unsupported symbolic-link path: $p"
done
[[ -f /var/www/html/index.php && -d "$themes/tenant" && -f "$db" ]] || die 'An existing standard Issabel installation with tenant is required.'
[[ ! -L "$destination" && ( ! -e "$destination" || -d "$destination" ) ]] || die 'Invalid theme destination.'
for p in /var/lib /var/lib/issabel "$state" "$lock_dir"; do
  if [[ -e "$p" ]]; then
    [[ -d "$p" && $(stat -c %u "$p") == 0 ]] || die "State directory must be owned by root: $p"
    mode=$(stat -c %a "$p")
    (( (8#$mode & 0022) == 0 )) || die "State directory is writable by other users: $p"
  fi
done
install -d -m 700 "$state" "$lock_dir"
for p in "$state" "$lock_dir"; do
  [[ -z $(find "$p" -type l -print -quit) ]] || die "Symbolic links are not allowed in $p"
done
for p in "$lock_dir/install.lock" "$state/managed" "$state/previous-theme" "$state/previous-language" "$state/restore-settings.sql"; do
  if [[ -e "$p" ]]; then
    [[ -f "$p" && $(stat -c %u "$p") == 0 && $(stat -c %h "$p") == 1 ]] || die "Unsafe state file: $p"
  fi
done
exec 9>"$lock_dir/install.lock"
flock -n 9 || die 'Another AKZ theme operation is running.'
sql() { sqlite3 -batch -bail -cmd '.timeout 10000' "$db" "$1"; }
[[ $(sql "SELECT count(*) FROM settings WHERE key='theme';") == 1 && $(sql "SELECT count(*) FROM settings WHERE key='language';") == 1 ]] || die 'Expected one theme and one language setting.'
current_theme=$(sql "SELECT value FROM settings WHERE key='theme';")
current_language=$(sql "SELECT value FROM settings WHERE key='language';")
valid_name() { [[ $1 =~ ^[a-zA-Z0-9_-]+$ ]]; }
valid_name "$current_theme" && valid_name "$current_language" || die 'Unsupported theme/language value.'
[[ -d "$themes/$current_theme" ]] || die 'The currently selected theme directory is missing.'

# Import only the two simple values written by the previous AKZ installer.
# Never source metadata or execute a saved SQL script as root.
if [[ ! -f "$state/previous-theme" && -f "$state/restore-settings.sql" ]]; then
  old_theme=$(sed -n "s/^UPDATE settings SET value='\([a-zA-Z0-9_-]*\)' WHERE key='theme';$/\1/p" "$state/restore-settings.sql")
  old_language=$(sed -n "s/^UPDATE settings SET value='\([a-zA-Z0-9_-]*\)' WHERE key='language';$/\1/p" "$state/restore-settings.sql")
  valid_name "$old_theme" && valid_name "$old_language" || die 'Legacy recovery values require manual review; nothing was deployed.'
  printf '%s\n' "$old_theme" > "$state/previous-theme"
  printf '%s\n' "$old_language" > "$state/previous-language"
fi

if [[ $action == uninstall ]]; then
  [[ -f "$state/managed" && -f "$state/previous-theme" && -f "$state/previous-language" ]] || die 'No activation recovery record was found.'
  old_theme=$(<"$state/previous-theme"); old_language=$(<"$state/previous-language")
  valid_name "$old_theme" && valid_name "$old_language" || die 'Invalid recovery values.'
  [[ -d "$themes/$old_theme" && ! -L "$themes/$old_theme" ]] || die 'The previous theme is unavailable; current selection was retained.'
  sql "BEGIN IMMEDIATE;
CREATE TEMP TABLE akz_restore AS SELECT value FROM settings WHERE key='theme' AND value='$theme';
UPDATE settings SET value='$old_language' WHERE key='language' AND value='$language' AND EXISTS (SELECT 1 FROM akz_restore);
UPDATE settings SET value='$old_theme' WHERE key='theme' AND value='$theme';
COMMIT;"
  echo 'Previous selection restored if this edition was active. Later language choices were preserved.'
  echo 'Theme files and recovery records are retained so the other edition can still restore them.'
  exit 0
fi

[[ ! -e "$destination" || -f "$state/managed" ]] || die 'An unmanaged theme directory already exists; refusing to overwrite it.'
[[ -f "$source_dir/themesetup.php" && -s "$source_dir/css/$theme-tailwind.css" && -s "$source_dir/js/$theme-ui.js" && -s "$source_dir/_common/login.tpl" ]] || die 'Incomplete package: keep framework and contrib together.'
[[ -z $(find "$source_dir" ! -type f ! -type d -print -quit) ]] || die 'Package contains symlinks or special files.'
if [[ $theme == akzfa && $activate == true ]]; then
  [[ -s /var/www/html/lang/fa.lang ]] || die 'The installed Issabel Persian language pack (lang/fa.lang) is required for activation.'
fi

backup=$(mktemp -d "$state/backup-$(date -u +%Y%m%dT%H%M%SZ)-XXXXXXXX")
stage=$(mktemp -d "$themes/.$theme-stage-XXXXXXXX")
deployed=false; moved_old=false; activation_attempted=false
for name in managed previous-theme previous-language; do
  if [[ -f "$state/$name" ]]; then cp -p -- "$state/$name" "$backup/$name"; fi
done
rollback() {
  result=$?
  trap - EXIT HUP INT TERM
  if [[ $result -ne 0 ]]; then
    set +e
    if [[ $activation_attempted == true ]]; then
      sql "BEGIN IMMEDIATE;
CREATE TEMP TABLE akz_restore AS SELECT value FROM settings WHERE key='theme' AND value='$theme';
UPDATE settings SET value='$current_language' WHERE key='language' AND value='$language' AND EXISTS (SELECT 1 FROM akz_restore);
UPDATE settings SET value='$current_theme' WHERE key='theme' AND value='$theme'; COMMIT;"
      if [[ $? -ne 0 ]]; then
        echo "Settings recovery failed. New theme retained; recovery files: $backup; $stage" >&2
        exit "$result"
      fi
    fi
    if [[ $deployed == true ]]; then mv -- "$destination" "$stage/failed-install"; fi
    if [[ $moved_old == true ]]; then mv -- "$stage/previous" "$destination"; fi
    for name in managed previous-theme previous-language; do
      if [[ -f "$backup/$name" ]]; then cp -p -- "$backup/$name" "$state/$name";
      elif [[ -f "$state/$name" ]]; then mv -- "$state/$name" "$backup/failed-$name"; fi
    done
    echo "Installation failed; recovery files: $backup; $stage" >&2
  fi
  exit "$result"
}
trap rollback EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM
install -d -m 755 "$stage/new"
cp -a -- "$source_dir/." "$stage/new/"
find "$stage/new" -type d -exec chmod 755 {} +
find "$stage/new" -type f -exec chmod 644 {} +
chown -R root:root "$stage/new"
if [[ -d "$destination" ]]; then
  cp -a -- "$destination" "$backup/theme"
  mv -- "$destination" "$stage/previous"
  moved_old=true
fi
mv -- "$stage/new" "$destination"
deployed=true
# Relabel at the final path; never disable SELinux to install a theme.
if command -v restorecon >/dev/null; then restorecon -R "$destination"; fi
printf '2\n' > "$state/managed"
if [[ $activate == true ]]; then
  if [[ $current_theme != "$theme" ]]; then
    printf '%s\n' "$current_theme" > "$state/previous-theme"
    printf '%s\n' "$current_language" > "$state/previous-language"
  fi
  [[ -s "$state/previous-theme" && -s "$state/previous-language" ]] || die 'An active theme has no recovery record; refusing to change settings.'
  activation_attempted=true
  # Abort if an administrator changed the selection since it was captured.
  if ! sql "BEGIN IMMEDIATE;
CREATE TEMP TABLE akz_guard (ok INTEGER CHECK(ok=1));
INSERT INTO akz_guard SELECT CASE WHEN
 (SELECT value FROM settings WHERE key='theme')='$current_theme' AND
 (SELECT value FROM settings WHERE key='language')='$current_language' THEN 1 ELSE 0 END;
UPDATE settings SET value='$language' WHERE key='language';
UPDATE settings SET value='$theme' WHERE key='theme'; COMMIT;"; then
    activation_attempted=false
    die 'Activation transaction failed; previous files and recovery records will be restored.'
  fi
fi
trap - EXIT HUP INT TERM
# Keep the previous deployment outside the web root; backup/theme is already complete.
mv -- "$stage" "$backup/transaction" || echo "Private staging directory retained: $stage" >&2
printf 'Installed %s. Recovery files: %s\n' "$theme" "$backup"
if [[ $activate == true ]]; then echo 'Theme and language selected. Sign out and sign in again.'; fi
