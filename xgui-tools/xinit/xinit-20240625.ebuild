# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X Window System initializer"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=8252e334c5cc381d5a32bc4d3d47bae1bfc94fe0
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xinit/-/archive/${SNAPSHOT}/xinit-${SNAPSHOT}.tar.bz2 -> xinit-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xinit-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-tools/xauth
	xgui-lib/libX11
"

PDEPEND="xgui-tools/xrdb"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default

	insinto etc/X11/xinit
	doins "${FILESDIR}"/xinitrc
}
