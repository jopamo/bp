# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="X Window System initializer"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-app/xauth
	xgui-live-lib/libX11
"

PDEPEND="xgui-live-app/xrdb"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default

	insinto etc/X11/xinit
	doins "${FILESDIR}"/xinitrc
}
