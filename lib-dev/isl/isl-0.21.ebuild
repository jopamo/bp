# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A library for manipulating integer points bounded by linear constraints"
HOMEPAGE="http://isl.gforge.inria.fr/"
SRC_URI="http://isl.gforge.inria.fr/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0/1"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND=">=lib-dev/gmp-5.1.3-r1"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	dev-util/pkgconf"

src_prepare() {
	default
	sed -i -e '/Libs:/s:@LDFLAGS@ ::' configure || die #382737
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
