# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools epatch flag-o-matic libtool

DESCRIPTION="\"M\"peg \"A\"udio \"D\"ecoder library"
HOMEPAGE="http://mad.sourceforge.net"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug static-libs"

src_prepare() {
	epatch \
		"${FILESDIR}"/libmad-0.15.1b-cflags.patch \
		"${FILESDIR}"/libmad-0.15.1b-cflags-O2.patch \
		"${FILESDIR}"/libmad-0.15.1b-gcc44-mips-h-constraint-removal.patch

	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/' configure.ac || die

	eautoreconf
}

src_configure() {
	local myconf="--enable-accuracy"

	[[ $(tc-arch) == "amd64" ]] && myconf+=" --enable-fpm=64bit"

	ECONF_SOURCE="${S}" econf \
		$(use_enable debug debugging) \
		$(use_enable static-libs static) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	# This file must be updated with each version update
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${FILESDIR}"/mad.pc

	# Use correct libdir in pkgconfig file
	sed -i -e "s:^libdir.*:libdir=${EPREFIX}/usr/$(get_libdir):" \
		"${ED}"/usr/$(get_libdir)/pkgconfig/mad.pc

	find "${ED}" -name "*.la" -delete || die
}
