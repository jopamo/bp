# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gtkmm-$(ver_cut 1)-$(ver_cut 2)"

inherit meson

DESCRIPTION="the C++ API for GTK"
HOMEPAGE="https://github.com/GNOME/gtkmm"

SNAPSHOT=2f899d218fda5b63d27d340774e63cf5e0578610
SRC_URI="https://github.com/GNOME/gtkmm/archive/${SNAPSHOT}.tar.gz -> gtkmm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gtkmm-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/gtk$(ver_cut 1)"
