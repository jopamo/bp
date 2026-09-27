# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X.Org Xaw library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=bf5844da8c75bbd0a4f78cc073c19ac2e2857a64
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXaw/-/archive/${SNAPSHOT}/libXaw-${SNAPSHOT}.tar.bz2 -> libXaw-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxaw-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/libXpm"

src_prepare() {
	eautoreconf
	default
}
