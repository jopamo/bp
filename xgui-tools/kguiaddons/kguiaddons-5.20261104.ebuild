# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="kf$(ver_cut 1)"

inherit cmake xdg

DESCRIPTION="Framework providing assorted high-level user interface components"
HOMEPAGE="https://invent.kde.org/frameworks/kguiaddons"
SNAPSHOT=be20defff25e88eb360a728d75c0975709a741d9
SRC_URI="https://github.com/KDE/kguiaddons/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/kguiaddons-${SNAPSHOT}

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="test wayland"

RESTRICT="!test? ( test )"

RDEPEND="
	xgui-lib/qtbase:5
	xgui-lib/qtx11extras:5
	xgui-lib/libX11
	wayland? ( xgui-lib/qtwayland:5 )
"
DEPEND="${RDEPEND}
	xgui-lib/libxcb
"
BDEPEND="xgui-tools/extra-cmake-modules"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
		$(usex wayland '-DWITH_WAYLAND=ON' '-DWITH_WAYLAND=OFF')
	)

	cmake_src_configure
}

src_test() {
	local -x QT_QPA_PLATFORM=offscreen
	cmake_src_test
}

src_install() {
	cmake_src_install

	einfo "Installing environment file..."
	local envfile="${T}/78kf"
	echo "CONFIG_PROTECT=${EPREFIX}/usr/share/config" >> ${envfile}
	doenvd ${envfile}
}
