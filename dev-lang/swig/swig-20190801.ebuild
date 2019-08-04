# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"

SNAPSHOT=87bf8ae7aa25bdd024ca7c5f8f4216926393fa3c
SRC_URI="https://github.com/swig/swig/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3+ BSD BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="ccache doc pcre"
RESTRICT="test"

DEPEND="pcre? ( lib-dev/libpcre )
	ccache? ( lib-sys/zlib )"
RDEPEND="${DEPEND}"

src_prepare() {
	"${S}"/autogen.sh
	default
}

src_configure() {
	econf \
		$(use_enable ccache) \
		$(use_with pcre)
}

src_install() {
	default

	if use doc; then
		docinto html
		dodoc -r Doc/{Devel,Manual}
	fi
}
