# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 libtool

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
EGIT_REPO_URI="https://github.com/glennrp/libpng.git"
EGIT_BRANCH=libpng16

LICENSE="libpng"
SLOT="0/16"
KEYWORDS="amd64 arm64"
IUSE="apng static-libs"

RDEPEND=">=lib-sys/zlib-1.2.8-r1:="
DEPEND="${RDEPEND}
	app-compression/xz-utils"

src_prepare() {
	eautoreconf
	default
	if use apng; then
		eapply -p0 "${WORKDIR}"/${PN}-*-apng.patch
		# Don't execute symbols check with apng patch wrt #378111
		sed -i -e '/^check/s:scripts/symbols.chk::' Makefile.in || die
	fi
	elibtoolize
}

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
