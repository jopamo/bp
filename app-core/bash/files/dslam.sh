#!/bin/sh

set -e

BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"
BASHALIASES="$HOME/.bash_aliases"
COLORPS1="$HOME/.color_ps1"
ALIASSH="$HOME/.bashrc.d/alias.sh"
LSCOLORS="$HOME/.ls_colors"
INPUTRC="$HOME/.inputrc"
BASHRCD="$HOME/.bashrc.d"

ensure_bashrcd_exists() {
	if [ ! -d "$BASHRCD" ]; then
		mkdir -p "$BASHRCD"
		echo "Created $BASHRCD directory."
	else
		echo "$BASHRCD directory already exists."
	fi
}

download_file() {
	local url="$1"
	local file="$2"

	if curl -o "$file" "$url"; then
		echo "Downloaded $file successfully."
	else
		echo "Failed to download $file from $url." >&2
		exit 1
	fi
}

download_files() {
	download_file "https://raw.githubusercontent.com/jopamo/bp/main/app-core/bash/files/color_ps1" "$COLORPS1"
	download_file "https://raw.githubusercontent.com/jopamo/bp/main/app-core/bash/files/bashrc" "$BASHALIASES"
	download_file "https://raw.githubusercontent.com/jopamo/bp/main/app-core/bash/files/alias.sh" "$ALIASSH"
	download_file "https://raw.githubusercontent.com/jopamo/bp/main/app-core/coreutils/files/LS_COLORS" "$LSCOLORS"
	download_file "https://raw.githubusercontent.com/jopamo/bp/main/app-core/layout/files/inputrc" "$INPUTRC"
}

modify_bash_aliases() {
	if [ -e "$BASHALIASES" ]; then
		sed -i 's|/etc/bash/color_ps1|'"$COLORPS1"'|' "$BASHALIASES"
		echo "Modified $BASHALIASES to source the correct color_ps1 path."
	fi
}

reload_shell_config() {
	[ -f "$BASHRC" ] && source "$BASHRC"
	[ -f "$ZSHRC" ] && source "$ZSHRC"
	bind -f "$INPUTRC"
	echo "Reloaded shell configuration."
}

main() {
	ensure_bashrcd_exists
	download_files
	modify_bash_aliases
	reload_shell_config
}

main
