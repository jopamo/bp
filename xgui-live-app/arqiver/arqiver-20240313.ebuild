# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg qmake-utils

DESCRIPTION="Simple Qt archive manager based on libarchive"
HOMEPAGE="https://github.com/tsujan/Arqiver.git"

SNAPSHOT=84422f02578b28006c8540454353169e0a46c303
SRC_URI="https://github.com/tsujan/Arqiver/archive/${SNAPSHOT}.tar.gz -> Arqiver-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/Arqiver-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase
	xgui-lib/qtsvg
	xgui-lib/qtx11extras
	app-compression/libarchive[bsdtar]"

src_configure() {
	eqmake5 arqiver.pro
}

src_install() {
	emake INSTALL_ROOT="${ED}" install
	insinto /etc/xdg/arqiver
	doins "${FILESDIR}"/arq.conf

	rm -rf "${ED}"/usr/share/arqiver
}
