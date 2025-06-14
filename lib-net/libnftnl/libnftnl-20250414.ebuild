# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools

DESCRIPTION="Netlink API to the in-kernel nf_tables subsystem"
HOMEPAGE="https://netfilter.org/projects/nftables/"

SNAPSHOT=17190762f33f78090f5ff99a436c4cb866ac3ccd
SRC_URI="https://github.com/1g4-mirror/libnftnl/archive/${SNAPSHOT}.tar.gz -> libnftnl-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libnftnl-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-net/libmnl"
BDEPEND="app-dev/pkgconf"

pkg_setup() {
	CONFIG_CHECK="~NF_TABLES"
	linux-info_pkg_setup
}

src_prepare() {
	rm -rf build-aux
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
