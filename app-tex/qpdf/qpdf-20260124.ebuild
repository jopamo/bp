# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="stable"

inherit cmake dot-a

DESCRIPTION="Command-line tool for structural, content-preserving transformation of PDF files"
HOMEPAGE="http://qpdf.sourceforge.net/"
SNAPSHOT=a898bb3a7289d1d05789d6d3f0d5dd534943a8da
SRC_URI="https://github.com/qpdf/qpdf/archive/${SNAPSHOT}.tar.gz -> qpdf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qpdf-${SNAPSHOT}"

LICENSE="|| ( Apache-2.0 Artistic-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="xmedia-lib/libjpeg-turbo"
BDEPEND="app-lang/perl"

src_configure() {
	use static-libs && lto-guarantee-fat

	local mycmakeargs=(
		-D BUILD_STATIC_LIBS="$(usex static-libs)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	use static-libs && strip-lto-bytecode
}
