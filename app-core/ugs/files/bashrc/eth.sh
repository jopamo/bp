#!/bin/bash
# shellcheck disable=SC2148

# detect iproute2 availability
if command -v ip &>/dev/null; then
  use_iproute2=true
else
  use_iproute2=false
fi

# usage strings
usage_ifup="Usage: ifup <interface>"
usage_ifdown="Usage: ifdown <interface>"
usage_ip_add="Usage: ip_add <interface> <ip_address> [netmask]"
usage_ip_del="Usage: ip_del <interface> <ip_address>"
usage_route_add="Usage: route_add <network> <gateway>"
usage_route_del="Usage: route_del <network>"
usage_iface_stats="Usage: iface_stats <interface>"
usage_netns_add="Usage: netns_add <namespace>"
usage_netns_del="Usage: netns_del <namespace>"
usage_netns_exec="Usage: netns_exec <namespace> <command> [args...]"
usage_netns_ipaddr="Usage: netns_ipaddr <namespace>"
usage_veth_add="Usage: veth_add <veth1> <veth2>"
usage_veth_del="Usage: veth_del <veth>"
usage_list_interfaces="Usage: list_interfaces"

# print to stderr
_err() { printf '%s\n' "$*" >&2; }

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
  alias netns_add='echo "Namespace not supported with net-tools"'
  alias netns_del='echo "Namespace not supported with net-tools"'
  alias netns_exec='echo "Namespace not supported with net-tools"'
  alias netns_list='echo "Namespace not supported with net-tools"'
  alias netns_ipaddr='echo "Namespace not supported with net-tools"'
  alias veth_add='echo "veth not supported with net-tools"'
  alias veth_del='echo "veth not supported with net-tools"'

  ifup_nettools() {
    [ -z "$1" ] && _err "$usage_ifup" && return 1
    ifconfig "$1" up
  }
  ifdown_nettools() {
    [ -z "$1" ] && _err "$usage_ifdown" && return 1
    ifconfig "$1" down
  }
  ip_add_nettools() {
    # net-tools expects explicit netmask for IPv4
    [ -z "$1" ] || [ -z "$2" ] && _err "$usage_ip_add" && return 1
    if [ -n "$3" ]; then
      ifconfig "$1" "$2" netmask "$3"
    else
      ifconfig "$1" "$2"
    fi
  }
  ip_del_nettools() {
    # many net-tools builds support `ifconfig IFACE del IP`
    [ -z "$1" ] || [ -z "$2" ] && _err "$usage_ip_del" && return 1
    ifconfig "$1" del "$2"
  }
  route_add_nettools() {
    [ -z "$1" ] || [ -z "$2" ] && _err "$usage_route_add" && return 1
    route add -net "$1" gw "$2"
  }
  route_del_nettools() {
    [ -z "$1" ] && _err "$usage_route_del" && return 1
    route del -net "$1"
  }
  iface_stats_nettools() {
    [ -z "$1" ] && _err "$usage_iface_stats" && return 1
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
  alias netns_add='netns_add_iproute2'
  alias netns_del='netns_del_iproute2'
  alias netns_exec='netns_exec_iproute2'
  alias netns_list='ip netns list'
  alias netns_ipaddr='netns_ipaddr_iproute2'
  alias veth_add='veth_add_iproute2'
  alias veth_del='veth_del_iproute2'

  ifup_iproute2() {
    [ -z "$1" ] && _err "$usage_ifup" && return 1
    ip link set "$1" up
  }
  ifdown_iproute2() {
    [ -z "$1" ] && _err "$usage_ifdown" && return 1
    ip link set "$1" down
  }
  ip_add_iproute2() {
    [ -z "$1" ] || [ -z "$2" ] && _err "$usage_ip_add" && return 1
    ip addr add "$2" dev "$1"
  }
  ip_del_iproute2() {
    [ -z "$1" ] || [ -z "$2" ] && _err "$usage_ip_del" && return 1
    ip addr del "$2" dev "$1"
  }
  route_add_iproute2() {
    [ -z "$1" ] || [ -z "$2" ] && _err "$usage_route_add" && return 1
    ip route add "$1" via "$2"
  }
  route_del_iproute2() {
    [ -z "$1" ] && _err "$usage_route_del" && return 1
    ip route del "$1"
  }
  iface_stats_iproute2() {
    [ -z "$1" ] && _err "$usage_iface_stats" && return 1
    ip -s link show "$1"
  }
  list_interfaces_iproute2() {
    ip link show
  }
  netns_add_iproute2() {
    [ -z "$1" ] && _err "$usage_netns_add" && return 1
    ip netns add "$1"
  }
  netns_del_iproute2() {
    [ -z "$1" ] && _err "$usage_netns_del" && return 1
    ip netns del "$1"
  }
  netns_exec_iproute2() {
    [ $# -lt 2 ] && _err "$usage_netns_exec" && return 1
    local ns="$1"; shift
    ip netns exec "$ns" "$@"
  }
  netns_ipaddr_iproute2() {
    [ -z "$1" ] && _err "$usage_netns_ipaddr" && return 1
    ip netns exec "$1" ip addr
  }
  veth_add_iproute2() {
    [ -z "$1" ] || [ -z "$2" ] && _err "$usage_veth_add" && return 1
    ip link add "$1" type veth peer name "$2"
  }
  veth_del_iproute2() {
    [ -z "$1" ] && _err "$usage_veth_del" && return 1
    ip link del "$1"
  }
fi
