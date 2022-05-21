# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=743004c68e7358fb9cd4737450f2d9a34076aadf

inherit autotools flag-o-matic

DESCRIPTION="This is a continuation of Niels Möller's work on an argp library for systems which don't provide one."
HOMEPAGE="https://github.com/ericonr/argp-standalone"
SRC_URI="https://github.com/ericonr/argp-standalone/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="public-domain GPL-2 GPL-3 XC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="!lib-core/glibc"

PATCHES=( "${FILESDIR}/${PN}-shared.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default

	insinto /usr/include
	doins argp.h
}
