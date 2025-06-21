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
	"00:1A:79"
	"00:1B:21"
	"00:1D:7E"
	"00:22:15"
	"00:23:EB"
	"00:24:E8"
	"00:25:64"
	"00:26:BB"
	"00:27:10"
	"00:28:F8"
	"00:30:48"
	"00:60:2F"
	"00:0E:C6"
	"00:18:DE"
	"00:16:E6"
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

generate_systemd_link_file() {
	local interfaces=("$@")
	if [ ${#interfaces[@]} -eq 0 ]; then
		interfaces=($(ls /sys/class/net | grep -Ev '^(lo|ip_vti0)$'))
	fi
	for interface in "${interfaces[@]}"; do
		local mac_address=$(generate_random_mac)
		local link_file_name="00-$interface.network"
		cat <<EOF | sudo tee /etc/systemd/network/$link_file_name > /dev/null
[Match]
Name=$interface

[Link]
MACAddress=$mac_address
EOF
		echo "Systemd .network file created for $interface with MAC address $mac_address"
	done
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
		[ -z "$1" ] && echo "$usage_ifup" && return 1
		sudo ifconfig "$1" up
	}
	ifdown_nettools() {
		[ -z "$1" ] && echo "$usage_ifdown" && return 1
		sudo ifconfig "$1" down
	}
	ip_add_nettools() {
		[ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] && echo "$usage_ip_add" && return 1
		sudo ifconfig "$1" "$2" netmask "$3"
	}
	ip_del_nettools() {
		[ -z "$1" ] || [ -z "$2" ] && echo "$usage_ip_del" && return 1
		sudo ifconfig "$1" "$2"
	}
	route_add_nettools() {
		[ -z "$1" ] || [ -z "$2" ] && echo "$usage_route_add" && return 1
		sudo route add -net "$1" gw "$2"
	}
	route_del_nettools() {
		[ -z "$1" ] && echo "$usage_route_del" && return 1
		sudo route del -net "$1"
	}
	iface_stats_nettools() {
		[ -z "$1" ] && echo "$usage_iface_stats" && return 1
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
		[ -z "$1" ] && echo "$usage_ifup" && return 1
		sudo ip link set "$1" up
	}
	ifdown_iproute2() {
		[ -z "$1" ] && echo "$usage_ifdown" && return 1
		sudo ip link set "$1" down
	}
	ip_add_iproute2() {
		[ -z "$1" ] || [ -z "$2" ] && echo "$usage_ip_add" && return 1
		sudo ip addr add "$2" dev "$1"
	}
	ip_del_iproute2() {
		[ -z "$1" ] || [ -z "$2" ] && echo "$usage_ip_del" && return 1
		sudo ip addr del "$2" dev "$1"
	}
	route_add_iproute2() {
		[ -z "$1" ] || [ -z "$2" ] && echo "$usage_route_add" && return 1
		sudo ip route add "$1" via "$2"
	}
	route_del_iproute2() {
		[ -z "$1" ] && echo "$usage_route_del" && return 1
		sudo ip route del "$1"
	}
	iface_stats_iproute2() {
		[ -z "$1" ] && echo "$usage_iface_stats" && return 1
		ip -s link show "$1"
	}
	list_interfaces_iproute2() {
		ip link show
	}
	netns_add_iproute2() {
		[ -z "$1" ] && echo "$usage_netns_add" && return 1
		sudo ip netns add "$1"
	}
	netns_del_iproute2() {
		[ -z "$1" ] && echo "$usage_netns_del" && return 1
		sudo ip netns del "$1"
	}
	netns_exec_iproute2() {
		[ -z "$1" ] || [ -z "$2" ] && echo "$usage_netns_exec" && return 1
		sudo ip netns exec "$1" ${@:2}
	}
	netns_ipaddr_iproute2() {
		[ -z "$1" ] && echo "$usage_netns_ipaddr" && return 1
		sudo ip netns exec "$1" ip addr
	}
	veth_add_iproute2() {
		[ -z "$1" ] || [ -z "$2" ] && echo "$usage_veth_add" && return 1
		sudo ip link add "$1" type veth peer name "$2"
	}
	veth_del_iproute2() {
		[ -z "$1" ] && echo "$usage_veth_del" && return 1
		sudo ip link del "$1"
	}
fi
