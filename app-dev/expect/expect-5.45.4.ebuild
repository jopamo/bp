# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

MY_P="${PN}${PV}"
DESCRIPTION="tool for automating interactive applications"
HOMEPAGE="https://core.tcl-lang.org/expect/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}"/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug test"

RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}"/${P}-examples.patch )

src_prepare() {
	default
	sed -i "s:/usr/local/bin:${EPREFIX}/usr/bin:" expect.man || die

	eapply "${FILESDIR}"/${PN}-5.45-gfbsd.patch
	eapply "${FILESDIR}"/${PN}-5.44.1.15-ldflags.patch
	eapply "${FILESDIR}"/${PN}-5.45-headers.patch
	eapply "${FILESDIR}"/${PN}-5.45-format-security.patch
	eapply "${FILESDIR}"/${PN}-5.45.4-configure-in.patch
	eapply "${FILESDIR}"/${PN}-5.45.4-configure-clang16.patch
	eapply "${FILESDIR}"/${PN}-5.45-warnings.patch

	sed -i 's:ifdef HAVE_SYS_WAIT_H:ifndef NO_SYS_WAIT_H:' *.c || die

	mv configure.{in,ac} || die

	eautoconf
}

src_configure() {
	econf \
		--cache-file="${S}"/config.cache \
		--with-tcl="${EPREFIX}/usr/lib" \
		--disable-64bit \
		--enable-shared \
		--enable-threads \
		$(use_enable debug symbols mem)
}
