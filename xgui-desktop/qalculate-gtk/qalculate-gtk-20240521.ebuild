# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="Modern multi-purpose calculator"
HOMEPAGE="https://qalculate.github.io/"

SNAPSHOT=7ea20e359938fb8462f099657412b15a43ec5d0c
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
