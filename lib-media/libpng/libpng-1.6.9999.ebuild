# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 libtool

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
EGIT_REPO_URI="https://github.com/glennrp/libpng.git"
EGIT_BRANCH=libpng$(ver_cut 1)$(ver_cut 2)

LICENSE="libpng"
SLOT="0/16"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=lib-sys/zlib-1.2.8-r1:=
		app-compression/xz-utils"

PATCHES=( "${FILESDIR}"/libpng-1.6.37-apng.patch )

src_prepare() {
	default

	# Don't execute symbols check with apng patch wrt #378111
	sed -i -e '/^check/s:scripts/symbols.chk::' Makefile.in || die

	elibtoolize
}

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
