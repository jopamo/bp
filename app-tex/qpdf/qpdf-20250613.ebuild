# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Command-line tool for structural, content-preserving transformation of PDF files"
HOMEPAGE="http://qpdf.sourceforge.net/"
SNAPSHOT=7edffb40e2568ac4ba19dc0ca3e9a7e2b92c92f4
SRC_URI="https://github.com/qpdf/qpdf/archive/${SNAPSHOT}.tar.gz -> qpdf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qpdf-${SNAPSHOT}"

LICENSE="|| ( Apache-2.0 Artistic-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="xmedia-lib/libjpeg-turbo"
BDEPEND="app-lang/perl"

src_configure() {
	local mycmakeargs=(
		-D BUILD_STATIC_LIBS="$(usex static-libs)"
	)
	cmake_src_configure
}
