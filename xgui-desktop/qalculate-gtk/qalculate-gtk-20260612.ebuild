# Distributed under the terms of the GNU General Public License v2

inherit autotools xdg

DESCRIPTION="Modern multi-purpose calculator"
HOMEPAGE="https://qalculate.github.io/"
SNAPSHOT=891da71571a521803ebe484632e395cdaddee83a
SRC_URI="https://github.com/Qalculate/qalculate-gtk/archive/${SNAPSHOT}.tar.gz -> qalculate-gtk-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qalculate-gtk-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/gtk3
	xgui-lib/libqalculate
"

src_prepare() {
	default
	eautoreconf
}
