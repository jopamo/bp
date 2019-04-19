# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Password Checking Library"
HOMEPAGE="https://github.com/cracklib/cracklib/"
SRC_URI="https://github.com/cracklib/cracklib/releases/download/v${PV}/${P}.tar.bz2
		https://raw.githubusercontent.com/berzerk0/Probable-Wordlists/master/Real-Passwords/Top304Thousand-probable-v2.txt -> cracklib_dict"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="nls static-libs zlib"

DEPEND="zlib? ( >=lib-sys/zlib-1.2.8-r1 )"

PATCHES=( ${FILESDIR}/a1379d0081e14958b2ada6dcc1fcb7f128e4bd94.patch )

src_configure() {
	export ac_cv_header_zlib_h=$(usex zlib)
	export ac_cv_search_gzopen=$(usex zlib -lz no)
	ECONF_SOURCE=${S} \
	econf \
		--with-default-dict='/usr/lib/cracklib_dict' \
		--without-python \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	default
	insinto usr/share/dict/
	doins ${DISTDIR}/cracklib_dict
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		ebegin "Regenerating cracklib dictionary"
		create-cracklib-dict "${EPREFIX}"/usr/share/dict/* > /dev/null
		eend $?
	fi
}
