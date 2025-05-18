# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="property displayer for X"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=1845213851e1d17bf5648714e162c7df769fffc2
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xprop/-/archive/${SNAPSHOT}/xprop-${SNAPSHOT}.tar.bz2 -> xprop-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xprop-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/libX11
	xgui-tools/xorgproto
"

src_prepare() {
	default
	eautoreconf
}
