# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org autotools utility macros"
HOMEPAGE="https://www.x.org"

SNAPSHOT=1031f8cc5c7a170e278372ccdf2e70151b096ef7
SRC_URI="https://gitlab.freedesktop.org/xorg/util/macros/-/archive/${SNAPSHOT}/macros-${SNAPSHOT}.tar.bz2 -> macros-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/macros-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
