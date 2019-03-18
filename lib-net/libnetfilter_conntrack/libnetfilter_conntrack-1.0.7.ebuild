# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools linux-info

DESCRIPTION="programming interface (API) to the in-kernel connection tracking state table"
HOMEPAGE="https://www.netfilter.org/projects/libnetfilter_conntrack/"
SRC_URI="https://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND="
	>=lib-net/libmnl-1.0.3
	>=lib-net/libnfnetlink-1.0.0
"
DEPEND="
	${RDEPEND}
	dev-util/pkgconfig
"

DOCS=( README )

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is lt 2 6 18 ; then
		die "${PN} requires at least 2.6.18 kernel version"
	fi

	#netfilter core team has changed some option names with kernel 2.6.20
	if kernel_is lt 2 6 20 ; then
		CONFIG_CHECK="~IP_NF_CONNTRACK_NETLINK"
	else
		CONFIG_CHECK="~NF_CT_NETLINK"
	fi

	check_extra_config
}
