# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gnome-$(ver_cut 1)"

inherit meson xdg

DESCRIPTION="Mostly private use system icons."
HOMEPAGE="https://git.gnome.org/browse/adwaita-icon-theme/"
SNAPSHOT=cd08cb3dfd63e6ad6bff9c1d88490280b0f9a7af
SRC_URI="https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/archive/${SNAPSHOT}/adwaita-icon-theme-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/adwaita-icon-theme-${SNAPSHOT}"

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
