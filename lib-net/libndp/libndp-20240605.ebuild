# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for Neighbor Discovery Protocol"
HOMEPAGE="http://libndp.org"

SNAPSHOT=05e4ba7b0d126eea4c04387dcf40596059ee24af
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
