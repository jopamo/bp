# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
HOMEPAGE="https://github.com/akheron/jansson"

SNAPSHOT=e23f5580072cb64ce3ab27de2b5110d7ac252424
SRC_URI="${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/jansson-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}
