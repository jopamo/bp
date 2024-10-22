# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="Netlink API to the in-kernel nf_tables subsystem"
HOMEPAGE="https://netfilter.org/projects/nftables/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.xz"

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

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
