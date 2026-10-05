# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="gnome-$(ver_cut 1)"
inherit meson xdg

PROPERTIES+=" source-payload"

DESCRIPTION="Adwaita icon theme"
HOMEPAGE="https://gitlab.gnome.org/GNOME/adwaita-icon-theme"
SNAPSHOT=70ecd52fbe844304ed4f845a04a1757fa6284884
SRC_URI="https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/archive/${SNAPSHOT}/adwaita-icon-theme-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/adwaita-icon-theme-${SNAPSHOT}"

LICENSE=" || ( LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-lang/python
	xgui-lib/gtk4
"
