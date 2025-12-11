# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="zip and unzip forked from infozip"
HOMEPAGE="https://github.com/jopamo/zip-utils"
SNAPSHOT=b7c695a81e0a3a8c2b8c5145a1f88223a26dd635
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
