# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="Adwaita icon theme"
HOMEPAGE="https://gitlab.gnome.org/GNOME/adwaita-icon-theme"
SNAPSHOT=a98b2f7a8e3f344306485155d094ea0877520df6
SRC_URI="https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/archive/${SNAPSHOT}/adwaita-icon-theme-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/adwaita-icon-theme-${SNAPSHOT}"

LICENSE=" || ( LGPL-3 CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	app-lang/python
	xgui-lib/gtk4
"
