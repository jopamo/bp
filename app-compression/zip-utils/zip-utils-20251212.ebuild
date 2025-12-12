# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="zip and unzip forked from infozip"
HOMEPAGE="https://github.com/jopamo/zip-utils"
SNAPSHOT=c476156a2d80cf5cf3c09250c892c3f78b7db980
SRC_URI="https://github.com/jopamo/zip-utils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/zip-utils-${SNAPSHOT}"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="unicode"

DEPEND="app-compression/bzip2"

src_prepare() {
	append-cppflags -DNO_LCHMOD

	use unicode && append-cppflags -DUNICODE_SUPPORT -DUNICODE_WCHAR -DUTF8_MAYBE_NATIVE -DUSE_ICONV_MAPPING

	default
}
