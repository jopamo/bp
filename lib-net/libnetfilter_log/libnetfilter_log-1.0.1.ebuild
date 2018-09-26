# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info

DESCRIPTION="interface to packets that have been logged by the kernel packet filter"
HOMEPAGE="https://www.netfilter.org/projects/libnetfilter_log/"
SRC_URI="https://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"

RDEPEND=">=lib-net/libnfnetlink-1.0.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

CONFIG_CHECK="~NETFILTER_NETLINK_LOG"

pkg_setup() {
	linux-info_pkg_setup
	kernel_is lt 2 6 14 && die "requires at least 2.6.14 kernel version"
}
