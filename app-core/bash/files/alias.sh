#!/bin/bash

declare -A formatters=(
	["*.c"]="clang-format -i"
	["*.h"]="clang-format -i"
	["*.cpp"]="clang-format -i"
	["*.hpp"]="clang-format -i"
	["*.py"]="black"
	["*.sh"]="beautysh -t"
	["*.js"]="prettier --write"
	["*.ts"]="prettier --write"
	["*.java"]="clang-format -i"
	["*.go"]="gofmt -w"
)

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
alias sha3-256='openssl dgst -sha3-256'
alias sha3-512='openssl dgst -sha3-512'
alias weather='curl wttr.in'
alias memfree='sync; echo 3 > /proc/sys/vm/drop_caches; free -m'

if command -v ip &> /dev/null; then
	use_iproute2=true
else
	use_iproute2=false
fi

usage_ifup="Usage: ifup <interface>"
usage_ifdown="Usage: ifdown <interface>"
usage_ip_add="Usage: ip_add <interface> <ip_address> <netmask>"
usage_ip_del="Usage: ip_del <interface> <ip_address>"
usage_route_add="Usage: route_add <network> <gateway>"
usage_route_del="Usage: route_del <network>"
usage_iface_stats="Usage: iface_stats <interface>"
usage_netns_add="Usage: netns_add <namespace>"
usage_netns_del="Usage: netns_del <namespace>"
usage_netns_exec="Usage: netns_exec <namespace> <command>"
usage_netns_ipaddr="Usage: netns_ipaddr <namespace>"
usage_veth_add="Usage: veth_add <veth1> <veth2>"
usage_veth_del="Usage: veth_del <veth>"
usage_list_interfaces="Usage: list_interfaces"
usage_set_random_mac="Usage: set_random_mac <interface>"

NIC_PREFIXES=(
	"00:1A:79" # Atheros Communications
	"00:1B:21" # Intel Corporation
	"00:1D:7E" # Cisco Systems, Inc.
	"00:22:15" # Hewlett Packard
	"00:23:EB" # Apple, Inc.
	"00:24:E8" # Dell Inc.
	"00:25:64" # Intel Corporate
	"00:26:BB" # Sony Corporation
	"00:27:10" # Cisco-Linksys LLC
	"00:28:F8" # Cisco Systems, Inc.
	"00:30:48" # Samsung Electronics Co., Ltd.
	"00:60:2F" # Realtek Semiconductor Corp.
	"00:0E:C6" # ASUSTek COMPUTER INC.
	"00:18:DE" # NVIDIA
	"00:16:E6" # ZyXEL Communications Corporation
)

generate_random_mac() {
	local prefix="${NIC_PREFIXES[$RANDOM % ${#NIC_PREFIXES[@]}]}"
	local suffix=$(openssl rand -hex 3 | sed 's/\(..\)/\1:/g; s/:$//')
	echo "$prefix:$suffix"
}

set_random_mac() {
	if [ -z "$1" ]; then
		echo "$usage_set_random_mac"
		return 1
	fi
	local interface=$1
	local new_mac=$(generate_random_mac)

	if [ "$use_iproute2" = true ]; then
		sudo ip link set dev "$interface" down
		sudo ip link set dev "$interface" address "$new_mac"
		sudo ip link set dev "$interface" up
	else
		sudo ifconfig "$interface" down
		sudo ifconfig "$interface" hw ether "$new_mac"
		sudo ifconfig "$interface" up
	fi

	echo "Assigned MAC address $new_mac to $interface"
}

if [ "$use_iproute2" = false ]; then
	alias ifup='ifup_nettools'
	alias ifdown='ifdown_nettools'
	alias ip_add='ip_add_nettools'
	alias ip_del='ip_del_nettools'
	alias route_add='route_add_nettools'
	alias route_del='route_del_nettools'
	alias show_routes='netstat -nr'
	alias iface_stats='iface_stats_nettools'
	alias list_interfaces='list_interfaces_nettools'
	alias set_random_mac='set_random_mac'
	alias netns_add='echo "Namespace not supported with net-tools"'
	alias netns_del='echo "Namespace not supported with net-tools"'
	alias netns_exec='echo "Namespace not supported with net-tools"'
	alias netns_list='echo "Namespace not supported with net-tools"'
	alias netns_ipaddr='echo "Namespace not supported with net-tools"'
	alias veth_add='echo "veth not supported with net-tools"'
	alias veth_del='echo "veth not supported with net-tools"'

	ifup_nettools() {
		if [ -z "$1" ]; then
			echo "$usage_ifup"
			return 1
		fi
		sudo ifconfig "$1" up
	}

	ifdown_nettools() {
		if [ -z "$1" ]; then
			echo "$usage_ifdown"
			return 1
		fi
		sudo ifconfig "$1" down
	}

	ip_add_nettools() {
		if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
			echo "$usage_ip_add"
			return 1
		fi
		sudo ifconfig "$1" "$2" netmask "$3"
	}

	ip_del_nettools() {
		if [ -z "$1" ] || [ -z "$2" ]; then
			echo "$usage_ip_del"
			return 1
		fi
		sudo ifconfig "$1" "$2"
	}

	route_add_nettools() {
		if [ -z "$1" ] || [ -z "$2" ]; then
			echo "$usage_route_add"
			return 1
		fi
		sudo route add -net "$1" gw "$2"
	}

	route_del_nettools() {
		if [ -z "$1" ]; then
			echo "$usage_route_del"
			return 1
		fi
		sudo route del -net "$1"
	}

	iface_stats_nettools() {
		if [ -z "$1" ]; then
			echo "$usage_iface_stats"
			return 1
		fi
		ifconfig "$1"
	}

	list_interfaces_nettools() {
		ifconfig -a
	}

else
	alias ifup='ifup_iproute2'
	alias ifdown='ifdown_iproute2'
	alias ip_add='ip_add_iproute2'
	alias ip_del='ip_del_iproute2'
	alias route_add='route_add_iproute2'
	alias route_del='route_del_iproute2'
	alias show_routes='ip route show'
	alias iface_stats='iface_stats_iproute2'
	alias list_interfaces='list_interfaces_iproute2'
	alias set_random_mac='set_random_mac'
	alias netns_add='netns_add_iproute2'
	alias netns_del='netns_del_iproute2'
	alias netns_exec='netns_exec_iproute2'
	alias netns_list='ip netns list'
	alias netns_ipaddr='netns_ipaddr_iproute2'
	alias veth_add='veth_add_iproute2'
	alias veth_del='veth_del_iproute2'

	ifup_iproute2() {
		if [ -z "$1" ]; then
			echo "$usage_ifup"
			return 1
		fi
		sudo ip link set "$1" up
	}

	ifdown_iproute2() {
		if [ -z "$1" ]; then
			echo "$usage_ifdown"
			return 1
		fi
		sudo ip link set "$1" down
	}

	ip_add_iproute2() {
		if [ -z "$1" ] || [ -z "$2" ]; then
			echo "$usage_ip_add"
			return 1
		fi
		sudo ip addr add "$2" dev "$1"
	}

	ip_del_iproute2() {
		if [ -z "$1" ] || [ -z "$2" ]; then
			echo "$usage_ip_del"
			return 1
		fi
		sudo ip addr del "$2" dev "$1"
	}

	route_add_iproute2() {
		if [ -z "$1" ] || [ -z "$2" ]; then
			echo "$usage_route_add"
			return 1
		fi
		sudo ip route add "$1" via "$2"
	}

	route_del_iproute2() {
		if [ -z "$1" ]; then
			echo "$usage_route_del"
			return 1
		fi
		sudo ip route del "$1"
	}

	iface_stats_iproute2() {
		if [ -z "$1" ]; then
			echo "$usage_iface_stats"
			return 1
		fi
		ip -s link show "$1"
	}

	list_interfaces_iproute2() {
		ip link show
	}

	netns_add_iproute2() {
		if [ -z "$1" ]; then
			echo "$usage_netns_add"
			return 1
		fi
		sudo ip netns add "$1"
	}

	netns_del_iproute2() {
		if [ -z "$1" ]; then
			echo "$usage_netns_del"
			return 1
		fi
		sudo ip netns del "$1"
	}

	netns_exec_iproute2() {
		if [ -z "$1" ] || [ -z "$2" ]; then
			echo "$usage_netns_exec"
			return 1
		fi
		sudo ip netns exec "$1" ${@:2}
	}

	netns_ipaddr_iproute2() {
		if [ -z "$1" ]; then
			echo "$usage_netns_ipaddr"
			return 1
		fi
		sudo ip netns exec "$1" ip addr
	}

	veth_add_iproute2() {
		if [ -z "$1" ] || [ -z "$2" ]; then
			echo "$usage_veth_add"
			return 1
		fi
		sudo ip link add "$1" type veth peer name "$2"
	}

	veth_del_iproute2() {
		if [ -z "$1" ]; then
			echo "$usage_veth_del"
			return 1
		fi
		sudo ip link del "$1"
	}
fi

random_string() {
	if [ -z "$1" ]; then
		echo "Usage: random_string <length>"
		return 1
	fi
	tr -dc A-Za-z0-9 </dev/urandom | head -c "$1" ; echo
}

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

encrypt_file() {
	if [ -z "$1" ]; then
		echo "Usage: encrypt_file <file_to_encrypt>"
		return 1
	fi
	gpg --encrypt --sign --armor -r "$FILE_KEYID" "$1"
	echo "Encrypted file created: $1.asc"
}

decrypt_file() {
	if [ -z "$1" ]; then
		echo "Usage: decrypt_file <file_to_decrypt>"
		return 1
	fi
	gpg --decrypt "$1" > "${1%.asc}.decrypted"
	echo "Decrypted file created: ${1%.asc}.decrypted"
}

backup_gpg() {
	if [ -z "$1" ]; then
		echo "Usage: backup_gpg <backup_directory>"
		return 1
	fi
	local backup_dir=$1
	mkdir -p "$backup_dir"
	gpg --export --armor > "$backup_dir/public-keys.asc"
	gpg --export-secret-keys --armor > "$backup_dir/private-keys.asc"
	gpg --export-ownertrust > "$backup_dir/ownertrust-gpg.txt"
	echo "GPG keys and trust database have been backed up in '$backup_dir'"
}

restore_gpg() {
	if [ -z "$1" ]; then
		echo "Usage: restore_gpg <backup_directory>"
		return 1
	fi
	local backup_dir=$1
	gpg --import "$backup_dir/private-keys.asc"
	gpg --import "$backup_dir/public-keys.asc"
	gpg --import-ownertrust "$backup_dir/ownertrust-gpg.txt"
	echo "GPG keys and trust database have been restored from '$backup_dir'"
}

backup_ssh() {
	local timestamp=$(date +"%Y%m%d%H%M%S")
	local backup_filename="ssh_backup_$timestamp.tar.bz2"
	local encrypted_filename="$backup_filename.gpg"

	tar -cjf "$backup_filename" -C ~ .ssh
	gpg --symmetric --cipher-algo AES256 --force-mdc "$backup_filename"
	rm "$backup_filename"
	echo "Backup and encryption of .ssh directory completed: $(pwd)/$encrypted_filename"
}

rmcomments() {
	for type in "${!formatters[@]}"; do
		find . -type f -name "$type" -not -path '*/.git/*' -exec sed -i '2,$ s|//.*||; 2,$ s|#.*||' {} +
	done
	echo "Comments removed from files of types: ${!formatters[*]}"
}

formatrepo() {
	for type in "${!formatters[@]}"; do
		find . -type f -name "$type" -not -path '*/.git/*' -exec ${formatters[$type]} {} +
	done
	echo "Formatted files of types: ${!formatters[*]}"
}

start_ssh_agent() {
	systemctl --user enable ssh-agent
	systemctl --user start ssh-agent

	for key in ~/.ssh/*; do
		if [ -f "$key" ]; then
			filename=$(basename "$key")

			if [[ "$filename" != "authorized_keys" && \
				"$filename" != "config" && \
				"$filename" != "bkup" && \
				"$filename" != *.* ]]; then
					ssh-add "$key"
				fi
			fi
		done
	}

	backup_system() {
		# Display help message if requested
		if [[ "$1" == "-h" || "$1" == "--help" ]]; then
			echo "Usage: backup_system <target-directory> <output-archive>"
			echo "Example: backup_system / /path/to/backup/root-backup.tar.zst"
			return
		fi

		local TARGET="$1"
		local ARCHIVE="$2"

		[[ "$TARGET" != */ ]] && TARGET="${TARGET}/"

		[[ "$ARCHIVE" != *.tar.zst ]] && ARCHIVE="${ARCHIVE}.tar.zst"

		tar --create --file="$ARCHIVE" --use-compress-program="zstd -19 -T0" --one-file-system \
			--exclude="${TARGET}proc/*" \
			--exclude="${TARGET}sys/*" \
			--exclude="${TARGET}dev/*" \
			--exclude="${TARGET}run/*" \
			--exclude="${TARGET}tmp/*" \
			--exclude="${TARGET}mnt/*" \
			--exclude="${TARGET}media/*" \
			--exclude="${TARGET}var/cache/packages/*" \
			--exclude="${TARGET}var/cache/distfiles/*" \
			--exclude="${TARGET}var/log/*" \
			--exclude="${TARGET}swapfile" \
			--exclude="${TARGET}usr/src/*" \
			--exclude="${TARGET}usr/lib/python3.12/test/*" \
			--keep-directory-symlink \
			"$TARGET"
	}
