# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Stream-oriented XML parser library"
HOMEPAGE="https://github.com/libexpat/libexpat"

SNAPSHOT=72d7ce953827fe08a56b8ea64092f208be6ffc5b
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
