# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit cmake flag-o-matic

DESCRIPTION="Qt Tools collection (Assistant, Designer, Linguist, etc.)"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=e4992a22dc84b901f25dd5858ae7687dc42ff8a2
# Follow this qttools commit's gitlinks, not the submodules' branch tips.
# lockstep-gitlink: QLITEHTML_SNAPSHOT SNAPSHOT src/assistant/qlitehtml
# lockstep-gitlink: QTTOOLS_LITEHTML_SNAPSHOT QLITEHTML_SNAPSHOT src/3rdparty/litehtml
QLITEHTML_SNAPSHOT=c47c490ce9f58183ec0f1bf881a419496853685b
QTTOOLS_LITEHTML_SNAPSHOT=9bc84b8b8d15a4e50f18b327aa30955048b441c2
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
	>=xgui-lib/qtbase-6.12:6=
	>=xgui-lib/qtdeclarative-6.12:6=
	"

src_prepare() {
	rm -rf "${S}/src/assistant/qlitehtml" || die
	mv "${WORKDIR}/qlitehtml-${QLITEHTML_SNAPSHOT}" "${S}/src/assistant/qlitehtml" || die
	rm -rf "${S}/src/assistant/qlitehtml/src/3rdparty/litehtml" || die
	mv "${WORKDIR}/qttools-litehtml-${QTTOOLS_LITEHTML_SNAPSHOT}" \
		"${S}/src/assistant/qlitehtml/src/3rdparty/litehtml" || die

	eapply "${FILESDIR}"/${PN}-litehtml-exceptions.patch
	eapply "${FILESDIR}"/${PN}-litehtml-atoi.patch
	cmake_src_prepare
}

append-flags -ffat-lto-objects
