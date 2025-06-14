# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info flag-o-matic autotools

DESCRIPTION="interface to packets that have been logged by the kernel packet filter"
HOMEPAGE="https://www.netfilter.org/projects/libnetfilter_log/"

SNAPSHOT=248401076c063473314a589e16fcadaa294848a5
SRC_URI="https://github.com/1g4-mirror/libnetfilter_log/archive/${SNAPSHOT}.tar.gz -> libnetfilter_log-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libnetfilter_log-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-net/libnfnetlink"

CONFIG_CHECK="~NETFILTER_NETLINK_LOG"

src_prepare() {
	default
	eautoreconf
	filter-flags -Wl,-z,defs
}

pkg_setup() {
	linux-info_pkg_setup
}
