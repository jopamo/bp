# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Provides useful functions commonly found on BSD systems"
HOMEPAGE="https://libbsd.freedesktop.org/wiki/"
SRC_URI="https://${PN}.freedesktop.org/releases/${P}.tar.xz"

LICENSE="BSD BSD-2 BSD-4 ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-dev/libmd"

src_configure() {
	filter-flags -fno-semantic-interposition

	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}
