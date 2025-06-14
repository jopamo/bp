# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xaw library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=7a97e12d435e05fbb9ca2f20f1a116c4a23eb194
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
