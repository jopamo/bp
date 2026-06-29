#!/usr/bin/env bash

# Copyright (C) 2012 - 2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
# This file is licensed under the GPLv2+. Please see COPYING for more information.

umask "${PASSWORD_STORE_UMASK:-077}"
set -o pipefail

GPG_OPTS=( $PASSWORD_STORE_GPG_OPTS "--quiet" "--yes" "--compress-algo=none" "--no-encrypt-to" )
GPG="gpg"
export GPG_TTY="${GPG_TTY:-$(tty 2>/dev/null)}"
command -v gpg2 &>/dev/null && GPG="gpg2"
[[ -n $GPG_AGENT_INFO || $GPG == "gpg2" ]] && GPG_OPTS+=( "--batch" "--use-agent" )

PREFIX="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
PREFIX="${PREFIX%/}"
[[ -n $PREFIX ]] || PREFIX="/"
EXTENSIONS="${PASSWORD_STORE_EXTENSIONS_DIR:-$PREFIX/.extensions}"
X_SELECTION="${PASSWORD_STORE_X_SELECTION:-clipboard}"
CLIP_TIME="${PASSWORD_STORE_CLIP_TIME:-45}"
GENERATED_LENGTH="${PASSWORD_STORE_GENERATED_LENGTH:-25}"
CHARACTER_SET="${PASSWORD_STORE_CHARACTER_SET:-[:punct:][:alnum:]}"
CHARACTER_SET_NO_SYMBOLS="${PASSWORD_STORE_CHARACTER_SET_NO_SYMBOLS:-[:alnum:]}"

unset GIT_DIR GIT_WORK_TREE GIT_NAMESPACE GIT_INDEX_FILE GIT_INDEX_VERSION GIT_OBJECT_DIRECTORY GIT_COMMON_DIR
export GIT_CEILING_DIRECTORIES="$PREFIX/.."

#
# BEGIN helper functions
#

set_git() {
	INNER_GIT_DIR="${1%/*}"
	while [[ ! -d $INNER_GIT_DIR && ${INNER_GIT_DIR%/*}/ == "${PREFIX%/}/"* ]]; do
		INNER_GIT_DIR="${INNER_GIT_DIR%/*}"
	done
	[[ $(git -C "$INNER_GIT_DIR" rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || INNER_GIT_DIR=""
}
git_add_file() {
	[[ -n $INNER_GIT_DIR ]] || return
	git -C "$INNER_GIT_DIR" add "$1" || return
	[[ -n $(git -C "$INNER_GIT_DIR" status --porcelain "$1") ]] || return
	git_commit "$2"
}
git_commit() {
	local sign=""
	[[ -n $INNER_GIT_DIR ]] || return
	[[ $(git -C "$INNER_GIT_DIR" config --bool --get pass.signcommits) == "true" ]] && sign="-S"
	git -C "$INNER_GIT_DIR" commit $sign -m "$1"
}
yesno() {
	[[ -t 0 ]] || return 0
	local response
	read -r -p "$1 [y/N] " response
	[[ $response == [yY] ]] || exit 1
}
die() {
	echo "$@" >&2
	exit 1
}
gpg_decrypt() {
	"$GPG" -d "${GPG_OPTS[@]}" "$@"
}
gpg_decrypt_to_file() {
	local output="$1"
	shift
	"$GPG" -d -o "$output" "${GPG_OPTS[@]}" "$@"
}
gpg_encrypt_to_file() {
	local output="$1"
	shift
	"$GPG" -e "${GPG_RECIPIENT_ARGS[@]}" -o "$output" "${GPG_OPTS[@]}" "$@"
}
gpg_encrypt_stream_to_file() {
	local output="$1"
	"$GPG" -e "${GPG_RECIPIENT_ARGS[@]}" -o "$output" "${GPG_OPTS[@]}"
}
reject_symlink_target() {
	local path="$1"
	[[ ! -L $path ]] || die "Error: refusing to write through symlink: $path"
	[[ ! -e $path || -f $path ]] || die "Error: not a regular file: $path"
}
assert_no_symlink_components() {
	local path="$1" parent_only="${2:-0}" rel component current max index components
	[[ $path == "$PREFIX" || $path == "$PREFIX"/* ]] || die "Error: path escapes the password store: $path"
	rel="${path#$PREFIX}"
	rel="${rel#/}"
	[[ -n $rel ]] || return 0
	current="$PREFIX"
	IFS='/' read -r -a components <<< "$rel"
	max="${#components[@]}"
	[[ $parent_only -eq 1 && $max -gt 0 ]] && ((max--))
	for (( index = 0; index < max; ++index )); do
		component="${components[$index]}"
		current="$current/$component"
		[[ ! -L $current ]] || die "Error: refusing to follow symlink in store path: $current"
	done
}
make_temp_file_in_dir() {
	local dir="$1" base="$2" tmp
	tmp="$(mktemp "$dir/.${base}.tmp.XXXXXX")" || return 1
	chmod 600 "$tmp" || {
		rm -f -- "$tmp"
		return 1
	}
	printf '%s\n' "$tmp"
}
encrypt_atomic_from_file() {
	local dst="$1" src="$2" dir tmp
	reject_symlink_target "$dst"
	assert_no_symlink_components "$dst" 1
	dir="${dst%/*}"
	tmp="$(make_temp_file_in_dir "$dir" "${dst##*/}")" || return 1
	if gpg_encrypt_to_file "$tmp" "$src"; then
		mv -f -- "$tmp" "$dst" || {
			rm -f -- "$tmp"
			return 1
		}
	else
		rm -f -- "$tmp"
		return 1
	fi
}
encrypt_atomic_from_stdin() {
	local dst="$1" dir tmp
	reject_symlink_target "$dst"
	assert_no_symlink_components "$dst" 1
	dir="${dst%/*}"
	tmp="$(make_temp_file_in_dir "$dir" "${dst##*/}")" || return 1
	if gpg_encrypt_stream_to_file "$tmp"; then
		mv -f -- "$tmp" "$dst" || {
			rm -f -- "$tmp"
			return 1
		}
	else
		rm -f -- "$tmp"
		return 1
	fi
}
store_path() {
	local rel="$1"
	check_sneaky_paths "$rel"
	if [[ -n $rel ]]; then
		printf '%s/%s\n' "$PREFIX" "$rel"
	else
		printf '%s\n' "$PREFIX"
	fi
}
verify_file() {
	[[ -n $PASSWORD_STORE_SIGNING_KEY ]] || return 0
	[[ -f $1.sig ]] || die "Signature for $1 does not exist."
	local fingerprints="$($GPG $PASSWORD_STORE_GPG_OPTS --verify --status-fd=1 "$1.sig" "$1" 2>/dev/null | sed -n 's/^\[GNUPG:\] VALIDSIG \([A-F0-9]\{40\}\) .* \([A-F0-9]\{40\}\)$/\1\n\2/p')"
	local fingerprint found=0
	for fingerprint in $PASSWORD_STORE_SIGNING_KEY; do
		[[ $fingerprint =~ ^[A-F0-9]{40}$ ]] || continue
		[[ $fingerprints == *$fingerprint* ]] && { found=1; break; }
	done
	[[ $found -eq 1 ]] || die "Signature for $1 is invalid."
}
set_gpg_recipients() {
	GPG_RECIPIENT_ARGS=( )
	GPG_RECIPIENTS=( )
	local gpg_id

	if [[ -n $PASSWORD_STORE_KEY ]]; then
		for gpg_id in $PASSWORD_STORE_KEY; do
			GPG_RECIPIENT_ARGS+=( "-r" "$gpg_id" )
			GPG_RECIPIENTS+=( "$gpg_id" )
		done
		return
	fi

	local current="$PREFIX/$1"
	while [[ $current != "$PREFIX" && ! -f $current/.gpg-id ]]; do
		current="${current%/*}"
	done
	current="$current/.gpg-id"

	if [[ ! -f $current ]]; then
		cat >&2 <<-_EOF
		Error: You must run:
		    $PROGRAM init your-gpg-id
		before you may use the password store.

		_EOF
		cmd_usage
		exit 1
	fi

	verify_file "$current"

	while read -r gpg_id; do
		gpg_id="${gpg_id%%#*}" # strip comment
		[[ -n $gpg_id ]] || continue
		GPG_RECIPIENT_ARGS+=( "-r" "$gpg_id" )
		GPG_RECIPIENTS+=( "$gpg_id" )
	done < "$current"
}

reencrypt_path() {
	local prev_gpg_recipients="" gpg_keys="" current_keys="" index passfile
	local groups="$($GPG $PASSWORD_STORE_GPG_OPTS --list-config --with-colons | grep "^cfg:group:.*")"
	while read -r -d "" passfile; do
		[[ -L $passfile ]] && continue
		local passfile_dir="${passfile%/*}"
		passfile_dir="${passfile_dir#$PREFIX}"
		passfile_dir="${passfile_dir#/}"
		local passfile_display="${passfile#$PREFIX/}"
		passfile_display="${passfile_display%.gpg}"
		set_gpg_recipients "$passfile_dir"
		if [[ $prev_gpg_recipients != "${GPG_RECIPIENTS[*]}" ]]; then
			for index in "${!GPG_RECIPIENTS[@]}"; do
				local group="$(sed -n "s/^cfg:group:$(sed 's/[\/&]/\\&/g' <<<"${GPG_RECIPIENTS[$index]}"):\\(.*\\)\$/\\1/p" <<<"$groups" | head -n 1)"
				[[ -z $group ]] && continue
				local old_ifs="$IFS" group_recipients
				IFS=';'
				read -r -a group_recipients <<< "$group"
				IFS="$old_ifs"
				GPG_RECIPIENTS+=( "${group_recipients[@]}" )
				unset "GPG_RECIPIENTS[$index]"
			done
			gpg_keys="$($GPG $PASSWORD_STORE_GPG_OPTS --list-keys --with-colons "${GPG_RECIPIENTS[@]}" | sed -n 's/^sub:[^idr:]*:[^:]*:[^:]*:\([^:]*\):[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:[a-zA-Z]*e[a-zA-Z]*:.*/\1/p' | LC_ALL=C sort -u)"
		fi
		current_keys="$(LC_ALL=C $GPG $PASSWORD_STORE_GPG_OPTS -v --no-secmem-warning --no-permission-warning --decrypt --list-only --keyid-format long "$passfile" 2>&1 | sed -nE 's/^gpg: public key is ([A-F0-9]+)$/\1/p' | LC_ALL=C sort -u)"

		if [[ $gpg_keys != "$current_keys" ]]; then
			echo "$passfile_display: reencrypting to ${gpg_keys//$'\n'/ }"
			gpg_decrypt "$passfile" | encrypt_atomic_from_stdin "$passfile" || die "Could not reencrypt $passfile_display."
		fi
		prev_gpg_recipients="${GPG_RECIPIENTS[*]}"
	done < <(find "$1" -path '*/.git' -prune -o -path '*/.extensions' -prune -o -iname '*.gpg' -print0)
}
check_sneaky_paths() {
	local path scan_path
	for path in "$@"; do
		[[ -n $path ]] || continue
		[[ $path != /* ]] || die "Error: absolute paths are not allowed: $path"
		[[ $path != *[[:cntrl:]]* ]] || die "Error: control characters are not allowed in paths."
		scan_path="$path"
		while [[ $scan_path == */ && $scan_path != "/" ]]; do
			scan_path="${scan_path%/}"
		done
		case "/$scan_path/" in
		*//*)
			die "Error: empty path components are not allowed: $path"
			;;
		*/./*|*/../*)
			die "Error: invalid path component: $path"
			;;
		esac
	done
}
path_matches_terms() {
	local path="${1,,}" term
	shift
	for term in "$@"; do
		[[ $path == *"${term,,}"* ]] && return 0
	done
	return 1
}
print_matching_paths_tree() {
	local prefix="$1" indent="$2" full_path child
	local -A seen=( )
	local -a children=( )
	local IFS=$'\n'

	for full_path in "${!MATCHED_PATHS[@]}"; do
		if [[ -z $prefix ]]; then
			child="${full_path%%/*}"
		elif [[ $full_path == "$prefix/"* ]]; then
			child="${full_path#"$prefix/"}"
			child="${child%%/*}"
		else
			continue
		fi
		[[ -n $child && -z ${seen[$child]} ]] || continue
		seen["$child"]=1
		children+=( "$child" )
	done

	((${#children[@]})) || return 0
	while read -r child; do
		printf '%s%s\n' "$indent" "$child"
		full_path="${prefix:+$prefix/}$child"
		print_matching_paths_tree "$full_path" "    $indent"
	done < <(printf '%s\n' "${children[@]}" | LC_ALL=C sort -f)
}
print_store_tree() {
	local dir="$1" indent="$2" entry name target
	local -a entries=( )
	local had_nullglob=0 had_dotglob=0

	shopt -q nullglob && had_nullglob=1
	shopt -q dotglob && had_dotglob=1
	shopt -s nullglob dotglob
	for entry in "$dir"/* "$dir"/.*; do
		name="${entry##*/}"
		[[ $name == "." || $name == ".." || $name == .* ]] && continue
		entries+=( "$entry" )
	done
	[[ $had_nullglob -eq 1 ]] || shopt -u nullglob
	[[ $had_dotglob -eq 1 ]] || shopt -u dotglob

	((${#entries[@]})) || return 0
	while IFS= read -r entry; do
		name="${entry##*/}"
		if [[ -L $entry ]]; then
			target="$(readlink -- "$entry")"
			printf '%s%s -> %s\n' "$indent" "${name%.gpg}" "$target"
		elif [[ -d $entry ]]; then
			printf '%s%s\n' "$indent" "$name"
			print_store_tree "$entry" "    $indent"
		else
			printf '%s%s\n' "$indent" "${name%.gpg}"
		fi
	done < <(printf '%s\n' "${entries[@]}" | LC_ALL=C sort -f)
}

#
# END helper functions
#

#
# BEGIN platform definable
#

clip() {
	if [[ -n $WAYLAND_DISPLAY ]] && command -v wl-copy &> /dev/null; then
		local copy_cmd=( wl-copy )
		local paste_cmd=( wl-paste -n )
		if [[ $X_SELECTION == primary ]]; then
			copy_cmd+=( --primary )
			paste_cmd+=( --primary )
		fi
		local display_name="$WAYLAND_DISPLAY"
	elif [[ -n $DISPLAY ]] && command -v xclip &> /dev/null; then
		local copy_cmd=( xclip -selection "$X_SELECTION" )
		local paste_cmd=( xclip -o -selection "$X_SELECTION" )
		local display_name="$DISPLAY"
	else
		die "Error: No X11 or Wayland display and clipper detected"
	fi
	local sleep_argv0="password store sleep on display $display_name"

	# This base64 business is because bash cannot store binary data in a shell
	# variable. Specifically, it cannot store nulls nor (non-trivally) store
	# trailing new lines.
	pkill -f "^$sleep_argv0" 2>/dev/null && sleep 0.5
	local before="$("${paste_cmd[@]}" 2>/dev/null | $BASE64)"
	printf %s "$1" | "${copy_cmd[@]}" || die "Error: Could not copy data to the clipboard"
	(
		( exec -a "$sleep_argv0" bash <<<"trap 'kill %1' TERM; sleep '$CLIP_TIME' & wait" )
		local now="$("${paste_cmd[@]}" | $BASE64)"
		[[ $now != $(printf %s "$1" | $BASE64) ]] && before="$now"

		# It might be nice to programatically check to see if klipper exists,
		# as well as checking for other common clipboard managers. But for now,
		# this works fine -- if qdbus isn't there or if klipper isn't running,
		# this essentially becomes a no-op.
		#
		# Clipboard managers frequently write their history out in plaintext,
		# so we axe it here:
		qdbus org.kde.klipper /klipper org.kde.klipper.klipper.clearClipboardHistory &>/dev/null

		echo "$before" | $BASE64 -d | "${copy_cmd[@]}"
	) >/dev/null 2>&1 & disown
	echo "Copied $2 to clipboard. Will clear in $CLIP_TIME seconds."
}

qrcode() {
	if [[ -n $DISPLAY || -n $WAYLAND_DISPLAY ]]; then
		if type feh >/dev/null 2>&1; then
			echo -n "$1" | qrencode --size 10 -o - | feh -x --title "pass: $2" -g +200+200 -
			return
		elif type gm >/dev/null 2>&1; then
			echo -n "$1" | qrencode --size 10 -o - | gm display -title "pass: $2" -geometry +200+200 -
			return
		elif type display >/dev/null 2>&1; then
			echo -n "$1" | qrencode --size 10 -o - | display -title "pass: $2" -geometry +200+200 -
			return
		fi
	fi
	echo -n "$1" | qrencode -t utf8
}

tmpdir() {
	[[ -n $SECURE_TMPDIR ]] && return
	local warn=1
	[[ $1 == "nowarn" ]] && warn=0
	local template="$PROGRAM.XXXXXXXXXXXXX"
	if [[ -d /dev/shm && -w /dev/shm && -x /dev/shm ]]; then
		SECURE_TMPDIR="$(mktemp -d "/dev/shm/$template")"
		remove_tmpfile() {
			rm -rf "$SECURE_TMPDIR"
		}
		trap remove_tmpfile EXIT
	else
		[[ $warn -eq 1 ]] && yesno "$(cat <<-_EOF
		Your system does not have /dev/shm, which means that it may
		be difficult to entirely erase the temporary non-encrypted
		password file after editing.

		Are you sure you would like to continue?
		_EOF
		)"
		SECURE_TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/$template")"
		shred_tmpfile() {
			find "$SECURE_TMPDIR" -type f -exec $SHRED {} +
			rm -rf "$SECURE_TMPDIR"
		}
		trap shred_tmpfile EXIT
	fi

}
GETOPT="getopt"
SHRED="shred -f -z"
BASE64="base64"

source "$(dirname "$0")/platform/$(uname | cut -d _ -f 1 | tr '[:upper:]' '[:lower:]').sh" 2>/dev/null # PLATFORM_FUNCTION_FILE

#
# END platform definable
#


#
# BEGIN subcommand functions
#

cmd_version() {
	cat <<-_EOF
	============================================
	= pass: the standard unix password manager =
	=                                          =
	=                  v1.7.4                  =
	=                                          =
	=             Jason A. Donenfeld           =
	=               Jason@zx2c4.com            =
	=                                          =
	=      http://www.passwordstore.org/       =
	============================================
	_EOF
}

cmd_usage() {
	cmd_version
	echo
	cat <<-_EOF
	Usage:
	    $PROGRAM init [--path=subfolder,-p subfolder] gpg-id...
	        Initialize new password storage and use gpg-id for encryption.
	        Selectively reencrypt existing passwords using new gpg-id.
	    $PROGRAM [ls] [subfolder]
	        List passwords.
	    $PROGRAM find pass-names...
	    	List passwords that match pass-names.
	    $PROGRAM [show] [--clip[=line-number],-c[line-number]] pass-name
	        Show existing password and optionally put it on the clipboard.
	        If put on the clipboard, it will be cleared in $CLIP_TIME seconds.
	    $PROGRAM grep [GREPOPTIONS] search-string
	        Search for password files containing search-string when decrypted.
	    $PROGRAM insert [--echo,-e | --multiline,-m] [--force,-f] pass-name
	        Insert new password. Optionally, echo the password back to the console
	        during entry. Or, optionally, the entry may be multiline. Prompt before
	        overwriting existing password unless forced.
	    $PROGRAM edit pass-name
	        Insert a new password or edit an existing password using ${EDITOR:-vi}.
	    $PROGRAM generate [--no-symbols,-n] [--clip,-c] [--in-place,-i | --force,-f] pass-name [pass-length]
	        Generate a new password of pass-length (or $GENERATED_LENGTH if unspecified) with optionally no symbols.
	        Optionally put it on the clipboard and clear board after $CLIP_TIME seconds.
	        Prompt before overwriting existing password unless forced.
	        Optionally replace only the first line of an existing file with a new password.
	    $PROGRAM rm [--recursive,-r] [--force,-f] pass-name
	        Remove existing password or directory, optionally forcefully.
	    $PROGRAM mv [--force,-f] old-path new-path
	        Renames or moves old-path to new-path, optionally forcefully, selectively reencrypting.
	    $PROGRAM cp [--force,-f] old-path new-path
	        Copies old-path to new-path, optionally forcefully, selectively reencrypting.
	    $PROGRAM git git-command-args...
	        If the password store is a git repository, execute a git command
	        specified by git-command-args.
	    $PROGRAM help
	        Show this text.
	    $PROGRAM version
	        Show version information.

	More information may be found in the pass(1) man page.
	_EOF
}

cmd_init() {
	local opts id_path=""
	opts="$($GETOPT -o p: -l path: -n "$PROGRAM" -- "$@")"
	local err=$?
	eval set -- "$opts"
	while true; do case $1 in
		-p|--path) id_path="$2"; shift 2 ;;
		--) shift; break ;;
	esac done

	[[ $err -ne 0 || $# -lt 1 ]] && die "Usage: $PROGRAM $COMMAND [--path=subfolder,-p subfolder] gpg-id..."
	[[ -n $id_path ]] && check_sneaky_paths "$id_path"
	local id_dir
	id_dir="$(store_path "$id_path")"
	assert_no_symlink_components "$id_dir"
	[[ -n $id_path && ! -d $id_dir && -e $id_dir ]] && die "Error: $id_dir exists but is not a directory."

	local gpg_id="$id_dir/.gpg-id"
	set_git "$gpg_id"

	if [[ $# -eq 1 && -z $1 ]]; then
		[[ ! -f "$gpg_id" ]] && die "Error: $gpg_id does not exist and so cannot be removed."
		rm -v -f "$gpg_id" || exit 1
		if [[ -n $INNER_GIT_DIR ]]; then
			git -C "$INNER_GIT_DIR" rm -qr "$gpg_id"
			git_commit "Deinitialize ${gpg_id}${id_path:+ ($id_path)}."
		fi
		rmdir -p "${gpg_id%/*}" 2>/dev/null
	else
		mkdir -v -p "$id_dir"
		printf "%s\n" "$@" > "$gpg_id"
		local id_print="$(printf "%s, " "$@")"
		echo "Password store initialized for ${id_print%, }${id_path:+ ($id_path)}"
		git_add_file "$gpg_id" "Set GPG id to ${id_print%, }${id_path:+ ($id_path)}."
		if [[ -n $PASSWORD_STORE_SIGNING_KEY ]]; then
			local signing_keys=( ) key
			for key in $PASSWORD_STORE_SIGNING_KEY; do
				signing_keys+=( --default-key $key )
			done
			$GPG "${GPG_OPTS[@]}" "${signing_keys[@]}" --detach-sign "$gpg_id" || die "Could not sign .gpg_id."
			key="$($GPG "${GPG_OPTS[@]}" --verify --status-fd=1 "$gpg_id.sig" "$gpg_id" 2>/dev/null | sed -n 's/^\[GNUPG:\] VALIDSIG [A-F0-9]\{40\} .* \([A-F0-9]\{40\}\)$/\1/p')"
			[[ -n $key ]] || die "Signing of .gpg_id unsuccessful."
			git_add_file "$gpg_id.sig" "Signing new GPG id with ${key//[$IFS]/,}."
		fi
	fi

	reencrypt_path "$id_dir"
	git_add_file "$id_dir" "Reencrypt password store using new GPG id ${id_print%, }${id_path:+ ($id_path)}."
}

cmd_show() {
	local opts selected_line clip=0 qrcode=0
	opts="$($GETOPT -o q::c:: -l qrcode::,clip:: -n "$PROGRAM" -- "$@")"
	local err=$?
	eval set -- "$opts"
	while true; do case $1 in
		-q|--qrcode) qrcode=1; selected_line="${2:-1}"; shift 2 ;;
		-c|--clip) clip=1; selected_line="${2:-1}"; shift 2 ;;
		--) shift; break ;;
	esac done

	[[ $err -ne 0 || ( $qrcode -eq 1 && $clip -eq 1 ) ]] && die "Usage: $PROGRAM $COMMAND [--clip[=line-number],-c[line-number]] [--qrcode[=line-number],-q[line-number]] [pass-name]"

	local pass
	local path="$1"
	check_sneaky_paths "$path"
	local passdir
	passdir="$(store_path "$path")"
	local passfile="${passdir}.gpg"
	if [[ -f $passfile ]]; then
		if [[ $clip -eq 0 && $qrcode -eq 0 ]]; then
			pass="$(gpg_decrypt "$passfile" | $BASE64)" || exit $?
			echo "$pass" | $BASE64 -d
		else
			[[ $selected_line =~ ^[0-9]+$ ]] || die "Clip location '$selected_line' is not a number."
			pass="$(gpg_decrypt "$passfile" | tail -n +"${selected_line}" | head -n 1)" || exit $?
			[[ -n $pass ]] || die "There is no password to put on the clipboard at line ${selected_line}."
			if [[ $clip -eq 1 ]]; then
				clip "$pass" "$path"
			elif [[ $qrcode -eq 1 ]]; then
				qrcode "$pass" "$path"
			fi
		fi
	elif [[ -d $passdir ]]; then
		if [[ -z $path ]]; then
			echo "Password Store"
		else
			echo "${path%\/}"
		fi
		print_store_tree "$passdir" ""
	elif [[ -z $path ]]; then
		die "Error: password store is empty. Try \"pass init\"."
	else
		die "Error: $path is not in the password store."
	fi
}

cmd_find() {
	[[ $# -eq 0 ]] && die "Usage: $PROGRAM $COMMAND pass-names..."
	local old_ifs="$IFS"
	IFS=,
	echo "Search Terms: $*"
	IFS="$old_ifs"
	local path rel parent
	declare -gA MATCHED_PATHS=( )
	while read -r -d "" path; do
		rel="${path#$PREFIX/}"
		[[ -d $path ]] || rel="${rel%.gpg}"
		path_matches_terms "$rel" "$@" || continue
		MATCHED_PATHS["$rel"]=1
		parent="$rel"
		while [[ $parent == */* ]]; do
			parent="${parent%/*}"
			MATCHED_PATHS["$parent"]=1
		done
	done < <(find -L "$PREFIX" -mindepth 1 -path '*/.git' -prune -o -path '*/.extensions' -prune -o \( -type d -o -iname '*.gpg' \) -print0)
	print_matching_paths_tree "" ""
}

cmd_grep() {
	[[ $# -lt 1 ]] && die "Usage: $PROGRAM $COMMAND [GREPOPTIONS] search-string"
	local passfile grepresults
	while read -r -d "" passfile; do
		grepresults="$(gpg_decrypt "$passfile" | grep --color=always "$@")"
		[[ $? -ne 0 ]] && continue
		passfile="${passfile%.gpg}"
		passfile="${passfile#$PREFIX/}"
		local passfile_dir="${passfile%/*}/"
		[[ $passfile_dir == "${passfile}/" ]] && passfile_dir=""
		passfile="${passfile##*/}"
		printf "\e[94m%s\e[1m%s\e[0m:\n" "$passfile_dir" "$passfile"
		echo "$grepresults"
	done < <(find -L "$PREFIX" -path '*/.git' -prune -o -path '*/.extensions' -prune -o -iname '*.gpg' -print0)
}

cmd_insert() {
	local opts multiline=0 noecho=1 force=0
	opts="$($GETOPT -o mef -l multiline,echo,force -n "$PROGRAM" -- "$@")"
	local err=$?
	eval set -- "$opts"
	while true; do case $1 in
		-m|--multiline) multiline=1; shift ;;
		-e|--echo) noecho=0; shift ;;
		-f|--force) force=1; shift ;;
		--) shift; break ;;
	esac done

	[[ $err -ne 0 || ( $multiline -eq 1 && $noecho -eq 0 ) || $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND [--echo,-e | --multiline,-m] [--force,-f] pass-name"
	local path="${1%/}"
	check_sneaky_paths "$path"
	local passfile
	passfile="$(store_path "$path").gpg"
	set_git "$passfile"

	[[ $force -eq 0 && -e $passfile ]] && yesno "An entry already exists for $path. Overwrite it?"

	assert_no_symlink_components "${passfile%/*}"
	mkdir -p -v "${passfile%/*}"
	set_gpg_recipients "$(dirname -- "$path")"

	if [[ $multiline -eq 1 ]]; then
		echo "Enter contents of $path and press Ctrl+D when finished:"
		echo
		encrypt_atomic_from_stdin "$passfile" || die "Password encryption aborted."
	elif [[ $noecho -eq 1 ]]; then
		local password password_again
		while true; do
			read -r -p "Enter password for $path: " -s password || exit 1
			echo
			read -r -p "Retype password for $path: " -s password_again || exit 1
			echo
			if [[ $password == "$password_again" ]]; then
				printf '%s\n' "$password" | encrypt_atomic_from_stdin "$passfile" || die "Password encryption aborted."
				break
			else
				die "Error: the entered passwords do not match."
			fi
		done
	else
		local password
		read -r -p "Enter password for $path: " -e password
		printf '%s\n' "$password" | encrypt_atomic_from_stdin "$passfile" || die "Password encryption aborted."
	fi
	git_add_file "$passfile" "Add given password for $path to store."
}

cmd_edit() {
	[[ $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND pass-name"

	local path="${1%/}"
	check_sneaky_paths "$path"
	local passfile
	passfile="$(store_path "$path").gpg"
	assert_no_symlink_components "${passfile%/*}"
	mkdir -p -v "${passfile%/*}"
	set_gpg_recipients "$(dirname -- "$path")"
	set_git "$passfile"
	reject_symlink_target "$passfile"

	tmpdir #Defines $SECURE_TMPDIR
	local tmp_base tmp_file
	tmp_base="$(basename -- "${path//\//-}")"
	tmp_file="$(mktemp "$SECURE_TMPDIR/${tmp_base}.XXXXXX.txt")" || die "Error: could not create temporary file"
	chmod 600 "$tmp_file" || die "Error: could not protect temporary file"

	local action="Add"
	if [[ -f $passfile ]]; then
		gpg_decrypt_to_file "$tmp_file" "$passfile" || exit 1
		action="Edit"
	fi
	EDITOR="${EDITOR:-vi}" sh -c '${EDITOR} "$1"' sh "$tmp_file"
	[[ -f $tmp_file ]] || die "New password not saved."
	gpg_decrypt "$passfile" 2>/dev/null | diff - "$tmp_file" &>/dev/null && die "Password unchanged."
	while ! encrypt_atomic_from_file "$passfile" "$tmp_file"; do
		yesno "GPG encryption failed. Would you like to try again?"
	done
	git_add_file "$passfile" "$action password for $path using ${EDITOR:-vi}."
}

cmd_generate() {
	local opts qrcode=0 clip=0 force=0 characters="$CHARACTER_SET" inplace=0 pass
	opts="$($GETOPT -o nqcif -l no-symbols,qrcode,clip,in-place,force -n "$PROGRAM" -- "$@")"
	local err=$?
	eval set -- "$opts"
	while true; do case $1 in
		-n|--no-symbols) characters="$CHARACTER_SET_NO_SYMBOLS"; shift ;;
		-q|--qrcode) qrcode=1; shift ;;
		-c|--clip) clip=1; shift ;;
		-f|--force) force=1; shift ;;
		-i|--in-place) inplace=1; shift ;;
		--) shift; break ;;
	esac done

	[[ $err -ne 0 || ( $# -ne 2 && $# -ne 1 ) || ( $force -eq 1 && $inplace -eq 1 ) || ( $qrcode -eq 1 && $clip -eq 1 ) ]] && die "Usage: $PROGRAM $COMMAND [--no-symbols,-n] [--clip,-c] [--qrcode,-q] [--in-place,-i | --force,-f] pass-name [pass-length]"
	local path="$1"
	local length="${2:-$GENERATED_LENGTH}"
	check_sneaky_paths "$path"
	[[ $length =~ ^[0-9]+$ ]] || die "Error: pass-length \"$length\" must be a number."
	[[ $length -gt 0 ]] || die "Error: pass-length must be greater than zero."
	local passfile
	passfile="$(store_path "$path").gpg"
	assert_no_symlink_components "${passfile%/*}"
	mkdir -p -v "${passfile%/*}"
	set_gpg_recipients "$(dirname -- "$path")"
	set_git "$passfile"

	[[ $inplace -eq 0 && $force -eq 0 && -e $passfile ]] && yesno "An entry already exists for $path. Overwrite it?"

	read -r -n $length pass < <(LC_ALL=C tr -dc "$characters" < /dev/urandom)
	[[ ${#pass} -eq $length ]] || die "Could not generate password from /dev/urandom."
	if [[ $inplace -eq 0 ]]; then
		printf '%s\n' "$pass" | encrypt_atomic_from_stdin "$passfile" || die "Password encryption aborted."
	else
		{ printf '%s\n' "$pass"; gpg_decrypt "$passfile" | tail -n +2; } | encrypt_atomic_from_stdin "$passfile" || die "Could not reencrypt new password."
	fi
	local verb="Add"
	[[ $inplace -eq 1 ]] && verb="Replace"
	git_add_file "$passfile" "$verb generated password for ${path}."

	if [[ $clip -eq 1 ]]; then
		clip "$pass" "$path"
	elif [[ $qrcode -eq 1 ]]; then
		qrcode "$pass" "$path"
	else
		printf "\e[1mThe generated password for \e[4m%s\e[24m is:\e[0m\n\e[1m\e[93m%s\e[0m\n" "$path" "$pass"
	fi
}

cmd_delete() {
	local opts recursive="" force=0
	opts="$($GETOPT -o rf -l recursive,force -n "$PROGRAM" -- "$@")"
	local err=$?
	eval set -- "$opts"
	while true; do case $1 in
		-r|--recursive) recursive="-r"; shift ;;
		-f|--force) force=1; shift ;;
		--) shift; break ;;
	esac done
	[[ $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND [--recursive,-r] [--force,-f] pass-name"
	local path="$1"
	check_sneaky_paths "$path"

	local passdir
	passdir="$(store_path "${path%/}")"
	local passfile
	passfile="$(store_path "${path%/}").gpg"
	[[ -f $passfile && -d $passdir && $path == */ || ! -f $passfile ]] && passfile="${passdir%/}/"
	[[ -e $passfile ]] || die "Error: $path is not in the password store."
	set_git "$passfile"

	[[ $force -eq 1 ]] || yesno "Are you sure you would like to delete $path?"

	rm $recursive -f -v "$passfile"
	set_git "$passfile"
	if [[ -n $INNER_GIT_DIR && ! -e $passfile ]]; then
		git -C "$INNER_GIT_DIR" rm -qr "$passfile"
		set_git "$passfile"
		git_commit "Remove $path from store."
	fi
	rmdir -p "${passfile%/*}" 2>/dev/null
}

cmd_copy_move() {
	local opts move=1 force=0
	[[ $1 == "copy" ]] && move=0
	shift
	opts="$($GETOPT -o f -l force -n "$PROGRAM" -- "$@")"
	local err=$?
	eval set -- "$opts"
	while true; do case $1 in
		-f|--force) force=1; shift ;;
		--) shift; break ;;
	esac done
	[[ $# -ne 2 ]] && die "Usage: $PROGRAM $COMMAND [--force,-f] old-path new-path"
	check_sneaky_paths "$@"
	local old_path
	old_path="$(store_path "${1%/}")"
	local old_dir="$old_path"
	local new_path
	new_path="$(store_path "$2")"

	if ! [[ -f $old_path.gpg && -d $old_path && $1 == */ || ! -f $old_path.gpg ]]; then
		old_dir="${old_path%/*}"
		old_path="${old_path}.gpg"
	fi
	[[ -e $old_path ]] || die "Error: $1 is not in the password store."

	assert_no_symlink_components "${new_path%/*}"
	mkdir -p -v "${new_path%/*}"
	[[ -d $old_path || -d $new_path || $new_path == */ ]] || new_path="${new_path}.gpg"
	[[ ! -L $new_path ]] || die "Error: refusing to write through symlink: $new_path"

	local interactive="-i"
	[[ ! -t 0 || $force -eq 1 ]] && interactive="-f"

	set_git "$new_path"
	if [[ $move -eq 1 ]]; then
		mv $interactive -v "$old_path" "$new_path" || exit 1
		[[ -e "$new_path" ]] && reencrypt_path "$new_path"

		set_git "$new_path"
		if [[ -n $INNER_GIT_DIR && ! -e $old_path ]]; then
			git -C "$INNER_GIT_DIR" rm -qr "$old_path" 2>/dev/null
			set_git "$new_path"
			git_add_file "$new_path" "Rename ${1} to ${2}."
		fi
		set_git "$old_path"
		if [[ -n $INNER_GIT_DIR && ! -e $old_path ]]; then
			git -C "$INNER_GIT_DIR" rm -qr "$old_path" 2>/dev/null
			set_git "$old_path"
			[[ -n $(git -C "$INNER_GIT_DIR" status --porcelain "$old_path") ]] && git_commit "Remove ${1}."
		fi
		rmdir -p "$old_dir" 2>/dev/null
	else
		cp $interactive -r -v "$old_path" "$new_path" || exit 1
		[[ -e "$new_path" ]] && reencrypt_path "$new_path"
		git_add_file "$new_path" "Copy ${1} to ${2}."
	fi
}

cmd_git() {
	set_git "$PREFIX/"
	if [[ $1 == "init" ]]; then
		INNER_GIT_DIR="$PREFIX"
		git -C "$INNER_GIT_DIR" "$@" || exit 1
		git_add_file "$PREFIX" "Add current contents of password store."

		echo '*.gpg diff=gpg' > "$PREFIX/.gitattributes"
		git_add_file .gitattributes "Configure git repository for gpg file diff."
		git -C "$INNER_GIT_DIR" config --local diff.gpg.binary true
		git -C "$INNER_GIT_DIR" config --local diff.gpg.textconv "$GPG -d ${GPG_OPTS[*]}"
	elif [[ -n $INNER_GIT_DIR ]]; then
		tmpdir nowarn #Defines $SECURE_TMPDIR. We don't warn, because at most, this only copies encrypted files.
		export TMPDIR="$SECURE_TMPDIR"
		git -C "$INNER_GIT_DIR" "$@"
	else
		die "Error: the password store is not a git repository. Try \"$PROGRAM git init\"."
	fi
}

cmd_extension_or_show() {
	if ! cmd_extension "$@"; then
		COMMAND="show"
		cmd_show "$@"
	fi
}

SYSTEM_EXTENSION_DIR=""
cmd_extension() {
	check_sneaky_paths "$1"
	local user_extension system_extension extension
	[[ -n $SYSTEM_EXTENSION_DIR ]] && system_extension="$SYSTEM_EXTENSION_DIR/$1.bash"
	[[ $PASSWORD_STORE_ENABLE_EXTENSIONS == true ]] && user_extension="$EXTENSIONS/$1.bash"
	if [[ -n $user_extension && -f $user_extension && -x $user_extension ]]; then
		verify_file "$user_extension"
		extension="$user_extension"
	elif [[ -n $system_extension && -f $system_extension && -x $system_extension ]]; then
		extension="$system_extension"
	else
		return 1
	fi
	shift
	source "$extension" "$@"
	return 0
}

#
# END subcommand functions
#

PROGRAM="${0##*/}"
COMMAND="$1"

case "$1" in
	init) shift;			cmd_init "$@" ;;
	help|--help) shift;		cmd_usage "$@" ;;
	version|--version) shift;	cmd_version "$@" ;;
	show|ls|list) shift;		cmd_show "$@" ;;
	find|search) shift;		cmd_find "$@" ;;
	grep) shift;			cmd_grep "$@" ;;
	insert|add) shift;		cmd_insert "$@" ;;
	edit) shift;			cmd_edit "$@" ;;
	generate) shift;		cmd_generate "$@" ;;
	delete|rm|remove) shift;	cmd_delete "$@" ;;
	rename|mv) shift;		cmd_copy_move "move" "$@" ;;
	copy|cp) shift;			cmd_copy_move "copy" "$@" ;;
	git) shift;			cmd_git "$@" ;;
	*)				cmd_extension_or_show "$@" ;;
esac
exit 0
