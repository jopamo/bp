#!/bin/sh
set -eu

launcher=$1
export HOME="$2" XDG_CURRENT_DESKTOP=OneG4:HXM
export XDG_DATA_HOME="$HOME/data" XDG_DATA_DIRS="$HOME/distro-data"
export XDG_CONFIG_HOME="$HOME/config" XDG_CONFIG_DIRS="$HOME/distro-config"
export XDG_CACHE_HOME="$HOME/cache" XTE_EXECARG_COMPAT=0 XTE_CACHE_ENABLED=0

mkdir -p "$HOME/bin" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME/applications"
export PATH="$HOME/bin:$PATH"

cat > "$HOME/bin/terminal-fixture" <<'EOF'
#!/bin/sh
printf '<%s>\n' "$@" > "$HOME/argv"
pwd -P > "$HOME/cwd"
EOF
chmod +x "$HOME/bin/terminal-fixture"

entry="$XDG_DATA_HOME/applications/terminal-fixture.desktop"
cat > "$entry" <<'EOF'
[Desktop Entry]
Type=Application
Name=Terminal fixture
Exec=terminal-fixture
Terminal=false
Categories=System;TerminalEmulator;
EOF
printf '%s\n' terminal-fixture.desktop > "$XDG_CONFIG_HOME/oneg4-xdg-terminals.list"

if "$launcher" --print-id; then
	echo 'strict selection accepted a terminal without execution metadata' >&2
	exit 1
fi
test ! -e "$HOME/argv"

printf '%s\n' 'X-TerminalArgExec=-e' >> "$entry"
test "$("$launcher" --print-id)" = terminal-fixture.desktop
test ! -e "$HOME/argv"

mkdir "$HOME/work dir"
cd "$HOME/work dir"
pwd -P > "$HOME/expected-cwd"
"$launcher" -- --command 'two words' "á;\$variable" ''
printf '<%s>\n' -e --command 'two words' "á;\$variable" '' > "$HOME/expected-argv"
cmp "$HOME/expected-cwd" "$HOME/cwd"
cmp "$HOME/expected-argv" "$HOME/argv"
