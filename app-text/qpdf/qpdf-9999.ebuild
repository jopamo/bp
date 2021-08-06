# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Command-line tool for structural, content-preserving transformation of PDF files"
HOMEPAGE="http://qpdf.sourceforge.net/"
EGIT_REPO_URI="https://github.com/qpdf/qpdf.git"

LICENSE="|| ( Apache-2.0 Artistic-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="xmedia-live-lib/libjpeg-turbo"

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
