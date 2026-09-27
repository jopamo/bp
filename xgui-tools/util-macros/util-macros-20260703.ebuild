# Distributed under the terms of the GNU General Public License v2

inherit autotools

PROPERTIES+=" source-payload"

DESCRIPTION="X.Org autotools utility macros"
HOMEPAGE="https://www.x.org"

SNAPSHOT=ea1e15a4909ac8b03b2c5a08ac3810b385985157
SRC_URI="https://gitlab.freedesktop.org/xorg/util/macros/-/archive/${SNAPSHOT}/macros-${SNAPSHOT}.tar.bz2 -> macros-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/macros-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
