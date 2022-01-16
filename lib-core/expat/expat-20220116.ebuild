# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Stream-oriented XML parser library"
HOMEPAGE="https://github.com/libexpat/libexpat"

SNAPSHOT=57c7da69b78e3698e112a6b5da19d5109b8232d1
SRC_URI="${HOMEPAGE}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/libexpat-${SNAPSHOT}/expat

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		--without-docbook
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
