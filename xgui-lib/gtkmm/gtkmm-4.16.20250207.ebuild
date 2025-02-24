# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="the C++ API for GTK"
HOMEPAGE="https://github.com/GNOME/gtkmm"

SNAPSHOT=8ee69f23a1fa36a5fc4d073ecc6365d29acd87d4
SRC_URI="https://github.com/GNOME/gtkmm/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/gtk4"
