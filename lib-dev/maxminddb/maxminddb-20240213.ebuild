# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=c7f2d1dc9927c719371539c1d75f52028bffcd91

inherit autotools

DESCRIPTION="C library for the MaxMind DB file format"
HOMEPAGE="https://github.com/maxmind/libmaxminddb"
SRC_URI="https://github.com/maxmind/libmaxminddb/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-tests
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
