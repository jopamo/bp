# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=dfcfe7e2585a37d6aad3fbaa65a2baa5056274db

inherit autotools

DESCRIPTION="C library for the MaxMind DB file format"
HOMEPAGE="https://github.com/maxmind/libmaxminddb"
SRC_URI="https://github.com/maxmind/libmaxminddb/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/libmaxminddb-${SNAPSHOT}

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
