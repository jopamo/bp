# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="create dependencies in makefiles"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=2c03ef16e05c9eef6fcaf1fbd4b77356a17883b6
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
