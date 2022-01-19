# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Provides useful functions commonly found on BSD systems"
HOMEPAGE="https://libbsd.freedesktop.org/wiki/"
SRC_URI="https://${PN}.freedesktop.org/releases/${P}.tar.xz"

LICENSE="BSD BSD-2 BSD-4 ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-dev/libmd"

PATCHES=(
	"${FILESDIR}"/00_4feda8704972a1eac88b5ba9ff7add92c25245ab
	"${FILESDIR}"/01_c7a5d780ae58b6f7ae7d814fd5bc53cf1f58ee5f.patch
)

src_configure() {
	ECONF_SOURCE="${S}" econf $(use_enable static-libs static)
}
