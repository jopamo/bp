# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="Modern multi-purpose calculator"
HOMEPAGE="https://qalculate.github.io/"

SNAPSHOT=1c1e36b5e1971a65372850f38b5279c382343666
SRC_URI="https://github.com/Qalculate/qalculate-gtk/archive/${SNAPSHOT}.tar.gz -> qalculate-gtk-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qalculate-gtk-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/libqalculate"

src_prepare() {
	default
	eautoreconf
}
