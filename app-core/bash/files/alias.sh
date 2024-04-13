#!/bin/sh

alias ......='cd ../../../../..'
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'

alias expand='expand -t2'
alias unexpand='unexpand -t2'

alias imginfo="identify -format '-- %f -- \nType: %m\nSize: %b bytes\nResolution: %wpx x %hpx\nColors: %k'"
alias imgres="identify -format '%wx%h\n'"

alias k5='kill -9 %%'

alias ls='ls --color=auto -h'
alias lf='ls --color=auto -ap | grep -v /'
alias ll='ls --color=auto -lah'

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

alias list-ssh='ps ax | grep "ssh" | grep -v grep'
alias t='tail'

alias h='history'
alias j='jobs -l'

alias path='echo -e ${PATH//:/\\n}'

alias ping='ping -c 5'
alias fastping='ping -c 1000 -f'

alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

alias wget='wget -c'

alias df='df -HT'
alias du='du -ch --max-depth=1'

alias rsync='rsync -apvz'

alias random4='tr -dc A-Za-z0-9 </dev/urandom | head -c 4 ; echo '''
alias random8='tr -dc A-Za-z0-9 </dev/urandom | head -c 8 ; echo '''

alias sha3-256='openssl dgst -sha3-256'
alias sha3-512='openssl dgst -sha3-512'

alias start-ssh-agent='systemctl --user enable ssh-agent && \
	systemctl --user start ssh-agent && \
	ssh-add ~/.ssh/github && \
	ssh-add ~/.ssh/gitlab && \
	ssh-add ~/.ssh/remote1 && \
	ssh-add ~/.ssh/remote2 && \
	ssh-add ~/.ssh/remote3'

alias remove_comments="find . -type f \( -name '*.c' -o -name '*.h' \) -not -path '*/.git/*' -exec sed -i 's|//.*||' {} +"

alias format_repo="find . -type f \( -name '*.c' -o -name '*.h' \) -not -path '*/.git/*' -exec clang-format -i {} +"

alias format_commit="git diff --name-only --cached | grep -E '\.(c|h)$' | xargs clang-format -i"

sort_and_remove_duplicates() {
    if [ -f "$1" ]; then
        temp_file=$(mktemp)
        if sort "$1" | uniq > "$temp_file" && [ -s "$temp_file" ]; then
            mv "$temp_file" "$1"
        else
            echo "Failed to sort and remove duplicates or file is empty after processing."
            rm "$temp_file"
        fi
    else
        echo "File not found: $1"
    fi
}

replace_in_files() {
    local search_string="$1"
    local replacement_string="$2"
    local start_directory="${3:-.}"

    if [ -z "$search_string" ] || [ -z "$replacement_string" ]; then
        echo "Usage: replace_in_files \"search_string\" \"replacement_string\" [start_directory]"
        return 1
    fi

    find "$start_directory" -type f ! -path '*/.git/*' -exec grep -l "$search_string" {} + | xargs -d '\n' sed -i "s|$search_string|$replacement_string|g"

    echo "Replacement complete."
}
