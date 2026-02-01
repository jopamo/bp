# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="Modern multi-purpose calculator"
HOMEPAGE="https://qalculate.github.io/"
SNAPSHOT=87be27f6e9411dc1b096458d2e1b118566a0fab6
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
