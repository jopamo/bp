# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="An library to provide useful functions commonly found on BSD systems"
HOMEPAGE="https://libbsd.freedesktop.org/wiki/"
SRC_URI="https://${PN}.freedesktop.org/releases/${P}.tar.xz"

LICENSE="BSD BSD-2 BSD-4 ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

filter-flags -flto\=\*

src_configure() {
	# The build system will install libbsd-ctor.a despite of USE="-static-libs"
	# which is correct, see:
	# https://cgit.freedesktop.org/libbsd/commit/?id=c5b959028734ca2281250c85773d9b5e1d259bc8
	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}
