# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Async Resolver Library from OpenBSD/OpenSMTPD"
HOMEPAGE="https://github.com/OpenSMTPD/libasr"

SNAPSHOT=05b8bf7d480c25195b365552f9ed6021cd0a68e3
SRC_URI="https://github.com/OpenSMTPD/libasr/archive/${SNAPSHOT}.tar.gz -> libasr-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libasr-${SNAPSHOT}"

LICENSE="ISC BSD BSD-1 BSD-2 BSD-4"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}
