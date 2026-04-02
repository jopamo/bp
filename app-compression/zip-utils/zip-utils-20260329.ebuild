# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic qa-policy

DESCRIPTION="zip and unzip forked from infozip"
HOMEPAGE="https://gitlab.com/pjo/zip-utils"
SNAPSHOT=0149f4eebf0eab9a4fb2e1d7167cf199b3b2ca90
SRC_URI="https://gitlab.com/pjo/zip-utils/-/archive/${SNAPSHOT}/zip-utils-${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
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

src_configure() {
	qa-policy-configure
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
