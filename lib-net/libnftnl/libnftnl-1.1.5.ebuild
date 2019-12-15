# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info

DESCRIPTION="Netlink API to the in-kernel nf_tables subsystem"
HOMEPAGE="https://netfilter.org/projects/nftables/"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

DEPEND="lib-net/libmnl
		dev-util/pkgconf"

pkg_setup() {
	CONFIG_CHECK="~NF_TABLES"
	linux-info_pkg_setup
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	default
	cd tests || die
	./test-script.sh || die
}
