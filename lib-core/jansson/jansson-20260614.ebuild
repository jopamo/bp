# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
HOMEPAGE="https://github.com/akheron/jansson"
SNAPSHOT=a83a3476cdad203f6069a77adc7adf7acacb0236
SRC_URI="https://github.com/akheron/jansson/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}

src_install() {
	default
	qa-policy-install
}
