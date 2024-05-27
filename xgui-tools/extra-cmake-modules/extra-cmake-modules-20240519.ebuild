# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Extra modules and scripts for CMake"
HOMEPAGE="https://cgit.kde.org/extra-cmake-modules.git"

SNAPSHOT=0eb01b5d116290340cd0d71c3bf731caa87a2393
SRC_URI="https://github.com/KDE/extra-cmake-modules/archive/${SNAPSHOT}.tar.gz -> extra-cmake-modules-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/extra-cmake-modules-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="test"

DEPEND="
	app-compression/libarchive
	test? (	xgui-lib/qtbase )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_HTML_DOCS=OFF
		-DBUILD_MAN_DOCS=OFF
		-DBUILD_QTHELP_DOCS=OFF
		-DBUILD_TESTING="$(usex test)"
	)
	cmake_src_configure
}