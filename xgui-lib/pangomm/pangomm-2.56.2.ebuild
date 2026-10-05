# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="C++ bindings for Pango"
HOMEPAGE="https://www.gtkmm.org/"
SRC_URI="https://download.gnome.org/sources/${PN}/$(ver_cut 1-2)/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="2.48"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=xgui-lib/cairomm-1.15.1:1.16
	>=xgui-lib/glibmm-2.68
	>=xgui-lib/pango-1.56:0
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		-Dmaintainer-mode=false
		-Dbuild-documentation=false
	)
	meson_src_configure
}
