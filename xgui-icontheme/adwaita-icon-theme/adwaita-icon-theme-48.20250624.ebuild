# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gnome-$(ver_cut 1)"

inherit meson xdg

DESCRIPTION="Mostly private use system icons."
HOMEPAGE="https://git.gnome.org/browse/adwaita-icon-theme/"
SNAPSHOT=ed465372143ed17640a0bbdb4c856cb5b3773d8e
SRC_URI="https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/archive/${SNAPSHOT}/adwaita-icon-theme-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/adwaita-icon-theme-${SNAPSHOT}"

LICENSE=" || ( LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-build/gettext
	app-dev/pkgconf
	xgui-lib/gnome-common
	xgui-lib/gtk3
	xgui-lib/librsvg
"

RESTRICT="binchecks strip"
