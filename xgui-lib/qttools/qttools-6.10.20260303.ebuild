# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake flag-o-matic

DESCRIPTION="Qt Tools collection (Assistant, Designer, Linguist, etc.)"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=4b1a5798e42d9ca737cda924cceddd9db0cf1e01
QLITEHTML_SNAPSHOT=3fe5821dad98747d6e41c9ed54b86c3d0eee9daf
QTTOOLS_LITEHTML_SNAPSHOT=6ca1ab0419e770e6d35a1ef690238773a1dafcee
SRC_URI="
	https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2
	https://invent.kde.org/qt/playground/qlitehtml/-/archive/${QLITEHTML_SNAPSHOT}/qlitehtml-${QLITEHTML_SNAPSHOT}.tar.bz2
	https://invent.kde.org/qt/qt/qttools-litehtml/-/archive/${QTTOOLS_LITEHTML_SNAPSHOT}/qttools-litehtml-${QTTOOLS_LITEHTML_SNAPSHOT}.tar.bz2
"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase:$(ver_cut 1)
	xgui-lib/qtdeclarative:$(ver_cut 1)
	"

src_prepare() {
	rm -rf "${S}/src/assistant/qlitehtml" || die
	mv "${WORKDIR}/qlitehtml-${QLITEHTML_SNAPSHOT}" "${S}/src/assistant/qlitehtml" || die
	rm -rf "${S}/src/assistant/qlitehtml/src/3rdparty/litehtml" || die
	mv "${WORKDIR}/qttools-litehtml-${QTTOOLS_LITEHTML_SNAPSHOT}" \
		"${S}/src/assistant/qlitehtml/src/3rdparty/litehtml" || die

	cmake_src_prepare
}

append-flags -ffat-lto-objects
