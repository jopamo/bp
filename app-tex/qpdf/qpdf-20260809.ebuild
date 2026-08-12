# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="stable"

inherit cmake qa-policy

DESCRIPTION="Command-line tool for structural, content-preserving transformation of PDF files"
HOMEPAGE="http://qpdf.sourceforge.net/"
SNAPSHOT=babad179ce5db9a21635c8d1ac17baa59637eada
SRC_URI="https://github.com/qpdf/qpdf/archive/${SNAPSHOT}.tar.gz -> qpdf-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qpdf-${SNAPSHOT}"

LICENSE="|| ( Apache-2.0 Artistic-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="xmedia-lib/libjpeg-turbo"
BDEPEND="
	app-dev/patchelf
	app-lang/perl
"

src_configure() {
	qa-policy-configure

	local mycmakeargs=(
		-D BUILD_STATIC_LIBS="$(usex static-libs)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	qa-policy-install
}
