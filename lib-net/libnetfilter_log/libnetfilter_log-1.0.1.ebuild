# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info flag-o-matic

DESCRIPTION="interface to packets that have been logged by the kernel packet filter"
HOMEPAGE="https://www.netfilter.org/projects/libnetfilter_log/"
SRC_URI="https://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND=">=lib-net/libnfnetlink-1.0.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

CONFIG_CHECK="~NETFILTER_NETLINK_LOG"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

pkg_setup() {
	linux-info_pkg_setup
}
