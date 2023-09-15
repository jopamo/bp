# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/XKeyboardConfig"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git"
	inherit git-r3
else
	SRC_URI="https://www.x.org/releases/individual/data/${PN}/${P}.tar.xz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-build/gettext
	app-dev/intltool
"

src_configure() {
	local emesonargs=(
		-D xkb-base="${EPREFIX}/usr/share/X11/xkb"
		-D compat-rules=true
		-D xorg-rules-symlinks=true
	)
		meson_src_configure
}
