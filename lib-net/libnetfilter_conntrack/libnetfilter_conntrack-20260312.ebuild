# Distributed under the terms of the GNU General Public License v2

inherit autotools linux-info qa-policy

DESCRIPTION="programming interface (API) to the in-kernel connection tracking state table"
HOMEPAGE="https://www.netfilter.org/projects/libnetfilter_conntrack/"
SNAPSHOT=7e5397b9167bdd7597be809b8f088ff333e1ad31
SRC_URI="https://github.com/1g4-mirror/libnetfilter_conntrack/archive/${SNAPSHOT}.tar.gz -> libnetfilter_conntrack-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libnetfilter_conntrack-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"
BDEPEND="app-dev/patchelf"

DEPEND=">=lib-net/libmnl-1.0.3
	>=lib-net/libnfnetlink-1.0.0"

pkg_setup() {
	CONFIG_CHECK="~IP_NF_CONNTRACK_NETLINK"

	check_extra_config
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure

	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}

src_install() {
	default

	qa-policy-install
}
