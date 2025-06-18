# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
HOMEPAGE="https://github.com/akheron/jansson"
SNAPSHOT=96d160df90016066d04d493d1d69639474ba4f20
SRC_URI="https://github.com/akheron/jansson/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
