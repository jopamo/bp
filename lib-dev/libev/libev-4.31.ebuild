# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A high-performance event loop/event model with lots of feature"
HOMEPAGE="http://software.schmorp.de/pkg/libev.html"
SRC_URI="http://dist.schmorp.de/libev/${P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		--disable-maintainer-mode
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm "${ED}"/usr/include/event.h
}
