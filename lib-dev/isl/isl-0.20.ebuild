# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils multilib-minimal preserve-libs

DESCRIPTION="A library for manipulating integer points bounded by linear constraints"
HOMEPAGE="http://isl.gforge.inria.fr/"
SRC_URI="http://isl.gforge.inria.fr/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0/19"
KEYWORDS="amd64 arm64"
IUSE="static-libs"

RDEPEND=">=lib-dev/gmp-5.1.3-r1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	app-compression/xz-utils
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.19-gdb-autoload-dir.patch
	sed -i -e '/Libs:/s:@LDFLAGS@ ::' configure || die #382737
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
