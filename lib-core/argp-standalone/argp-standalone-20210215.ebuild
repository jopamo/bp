# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT="e5fe9ad9e83e6765cf8fa787f903d4c6792338b5"

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
