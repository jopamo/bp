# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 xdg

DESCRIPTION="Mostly private use system icons."
HOMEPAGE="https://git.gnome.org/browse/adwaita-icon-theme/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git"
EGIT_BRANCH="gnome-$(ver_cut 1)"

LICENSE=" || ( LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-build/gettext
	app-dev/pkgconf
	xgui-lib/librsvg
	xgui-lib/gnome-common
	xgui-lib/gtk3
"

RESTRICT="binchecks strip"

src_prepare() {
	default
	eautoreconf
}
