# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION="Framework providing assorted high-level user interface components"
EGIT_REPO_URI="https://github.com/KDE/kguiaddons.git"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="wayland"

DEPEND="
	xgui-live-app/xorgproto
	xgui-live-lib/libX11
	xgui-live-lib/libxcb
	xgui-live-lib/qtbase
	xgui-live-lib/qtx11extras
	wayland? ( xgui-live-lib/qtwayland )
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
