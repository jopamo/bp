# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Provides message digest functions found on BSD systems"
HOMEPAGE="https://www.hadrons.org/software/libmd/"
SRC_URI="https://libbsd.freedesktop.org/releases/${P}.tar.xz"

LICENSE="BSD BSD-2 BSD-4 ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}
