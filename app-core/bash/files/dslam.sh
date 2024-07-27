#!/bin/sh

BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"

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
download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/bash/files/bashrc "$HOME/.bashrc.d/bashrc"
download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/bash/files/alias.sh "$HOME/.bashrc.d/alias.sh"
download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/coreutils/files/LS_COLORS "$HOME/.ls_colors"
download_file https://raw.githubusercontent.com/jopamo/bp/main/app-core/layout/files/inputrc "$HOME/.inputrc"

if [ -e "$HOME/.bashrc.d/bashrc" ]; then
	sed -i 's|/etc/bash/color_ps1|'"$HOME"'/.color_ps1|' "$HOME/.bashrc.d/bashrc"
	echo "Modified $HOME/.bashrc.d/bashrc to source the correct path."
fi

update_shell_config() {
	local shell_config=$1

	if ! grep -q 'source ~/.bashrc.d/bashrc' "$shell_config"; then
		echo "source ~/.bashrc.d/bashrc" >> "$shell_config"
		echo "Updated $shell_config to source $HOME/.bashrc.d/bashrc."
	else
		echo "$shell_config already configured to source $HOME/.bashrc.d/bashrc."
	fi
}

if [ -f "$BASHRC" ]; then
	update_shell_config "$BASHRC"
	source "$BASHRC"
fi

if [ -f "$ZSHRC" ]; then
	update_shell_config "$ZSHRC"
	source "$ZSHRC"
fi

bind -f "$HOME/.inputrc"
echo "Reloaded shell configuration."
