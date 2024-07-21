# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for Neighbor Discovery Protocol"
HOMEPAGE="http://libndp.org"

SNAPSHOT=2730638bf88984b09531813974f9bd14e1a50165
SRC_URI="https://github.com/jpirko/libndp/archive/${SNAPSHOT}.tar.gz -> libndp-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libndp-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--disable-static
		--enable-logging
	)
	ECONF_SOURCE=${S} econf ${myconf[@]}
}
