# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="create dependencies in makefiles"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=e6b69b245d1000b71bee61195b4307411f37fac1
SRC_URI="https://gitlab.freedesktop.org/xorg/util/makedepend/-/archive/${SNAPSHOT}/makedepend-${SNAPSHOT}.tar.bz2 -> makedepend-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/makedepend-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="${RDEPEND}
	xgui-tools/xorgproto"

src_prepare() {
	eautoreconf
	default
}
