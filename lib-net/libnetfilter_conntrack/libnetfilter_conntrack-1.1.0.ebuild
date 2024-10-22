# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools linux-info

DESCRIPTION="programming interface (API) to the in-kernel connection tracking state table"
HOMEPAGE="https://www.netfilter.org/projects/libnetfilter_conntrack/"
SRC_URI="https://www.netfilter.org/projects/${PN}/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=lib-net/libmnl-1.0.3
	>=lib-net/libnfnetlink-1.0.0"

pkg_setup() {
	CONFIG_CHECK="~IP_NF_CONNTRACK_NETLINK"

	check_extra_config
}
