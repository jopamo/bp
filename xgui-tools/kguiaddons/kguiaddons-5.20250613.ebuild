# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="kf$(ver_cut 1)"

inherit cmake xdg

DESCRIPTION="Framework providing assorted high-level user interface components"
SNAPSHOT=6f896fe3aa8a4da33b528524ac7922d548148696
SRC_URI="https://github.com/KDE/kguiaddons/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/kguiaddons-${SNAPSHOT}

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="wayland"

DEPEND="
	xgui-lib/qtbase:5
	xgui-lib/qtx11extras:5
	wayland? ( xgui-lib/qtwayland:5 )
"

src_configure() {
	local mycmakeargs=(
		$(usex wayland '-DWITH_WAYLAND=ON' '-DWITH_WAYLAND=OFF')
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	einfo "Installing environment file..."
	local envfile="${T}/78kf"
	echo "CONFIG_PROTECT=${EPREFIX}/usr/share/config" >> ${envfile}
	doenvd ${envfile}
}
