# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="gtkmm-$(ver_cut 1)-$(ver_cut 2)"

inherit meson

DESCRIPTION="the C++ API for GTK"
HOMEPAGE="https://github.com/GNOME/gtkmm"

SNAPSHOT=2160941ea7e63daa74782e53c7089659b5628293
SRC_URI="https://github.com/GNOME/gtkmm/archive/${SNAPSHOT}.tar.gz -> gtkmm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gtkmm-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=xgui-lib/gtk4-4.22:4
	>=xgui-lib/glibmm-2.75
	>=xgui-lib/cairomm-1.15.4:1.16
	>=xgui-lib/pangomm-2.50:2.48
	>=xgui-lib/pigment-2.35.5
"
DEPEND="${RDEPEND}"
BDEPEND="xgui-tools/mm-common"

src_prepare() {
	default
	mm-common-prepare --copy --force "${S}" || die
}

src_configure() {
	local emesonargs=(
		-Dmaintainer-mode=true
		-Dbuild-documentation=false
		-Dbuild-demos=false
		-Dbuild-tests=false
	)
	meson_src_configure
}
