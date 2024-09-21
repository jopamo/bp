#!/bin/sh

BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"
BASHALIASES="$HOME/.bash_aliases"

if [ ! -d "$HOME/.bashrc.d" ]; then
	mkdir -p "$HOME/.bashrc.d"
	echo "Created $HOME/.bashrc.d directory."
else
	echo "$HOME/.bashrc.d directory already exists."
fi

download_file() {
	local url=$1
	local file=$2

	curl -o "$file" "$url"
	echo "Downloaded $file."
}

download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/bash/files/color_ps1 "$HOME/.color_ps1"
download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/bash/files/bashrc "$BASHALIASES"
download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/bash/files/alias.sh "$HOME/.bashrc.d/alias.sh"
download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/coreutils/files/LS_COLORS "$HOME/.ls_colors"
download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/layout/files/inputrc "$HOME/.inputrc"

if [ -e "$HOME/.bashrc.d/bashrc" ]; then
	sed -i 's|/etc/bash/color_ps1|'"$HOME"'/.color_ps1|' "$$BASHALIASES"
	echo "Modified $HOME/.bashrc.d/bashrc to source the correct path."
fi

if [ -f "$BASHRC" ]; then
	source "$BASHRC"
fi

if [ -f "$ZSHRC" ]; then
	source "$ZSHRC"
fi

bind -f "$HOME/.inputrc"
echo "Reloaded shell configuration."
