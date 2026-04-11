# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="kde/$(ver_cut 1-2)"

inherit qmake-utils flag-o-matic

DESCRIPTION="Qt Tools collection (Assistant, Designer, Linguist, etc.)"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=fa40a2d3373b89be0cd0a43fe0c1d047e3d34058
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase:$(ver_cut 1)"

src_prepare() {
	default

	local qtver
	qtver="$("$(qt5_get_bindir)"/qmake -query QT_VERSION)" || die
	"$(qt5_get_bindir)"/syncqt.pl -version "${qtver}" -outdir "${S}" "${S}" || die
}

src_configure() {
	append-flags -ffat-lto-objects

	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	cleanup_install
}
