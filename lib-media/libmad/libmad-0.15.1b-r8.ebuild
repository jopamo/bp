# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools epatch flag-o-matic libtool multilib-minimal

DESCRIPTION="\"M\"peg \"A\"udio \"D\"ecoder library"
HOMEPAGE="http://mad.sourceforge.net"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="debug static-libs"

RDEPEND="abi_x86_32? ( !<=app-misc/emul-linux-x86-medialibs-20130224-r3
		!app-misc/emul-linux-x86-medialibs[-abi_x86_32(-)] )"

DOCS=( CHANGES CREDITS README TODO VERSION )

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/mad.h
)

src_prepare() {
	epatch \
		"${FILESDIR}"/libmad-0.15.1b-cflags.patch \
		"${FILESDIR}"/libmad-0.15.1b-cflags-O2.patch \
		"${FILESDIR}"/libmad-0.15.1b-gcc44-mips-h-constraint-removal.patch

	# bug 467002
	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/' configure.ac || die

	eautoreconf
	# unnecessary when eautoreconf'd
#	elibtoolize
	# unnecessary when eautoreconf'd with new autoconf, for example, 2.69
#	epunt_cxx #74490
}

multilib_src_configure() {
	local myconf="--enable-accuracy"
	# --enable-speed		 optimize for speed over accuracy
	# --enable-accuracy		 optimize for accuracy over speed
	# --enable-experimental	 enable code using the EXPERIMENTAL
	#						 preprocessor define

	# Fix for b0rked sound on sparc64 (maybe also sparc32?)
	# default/approx is also possible, uses less cpu but sounds worse
	use sparc && myconf+=" --enable-fpm=64bit"

	[[ $(tc-arch) == "amd64" ]] && myconf+=" --enable-fpm=64bit"
	[[ $(tc-arch) == "x86" ]] && myconf+=" --enable-fpm=intel"

	ECONF_SOURCE="${S}" econf \
		$(use_enable debug debugging) \
		$(use_enable static-libs static) \
		${myconf}
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	# This file must be updated with each version update
	insinto /usr/$(get_libdir)/pkgconfig
	doins "${FILESDIR}"/mad.pc

	# Use correct libdir in pkgconfig file
	sed -i -e "s:^libdir.*:libdir=${EPREFIX}/usr/$(get_libdir):" \
		"${ED}"/usr/$(get_libdir)/pkgconfig/mad.pc

	find "${ED}" -name "*.la" -delete || die
}
