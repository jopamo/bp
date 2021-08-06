# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="KeePassXC - KeePass Cross-platform Community Edition"
HOMEPAGE="https://keepassxc.org"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/keepassxreboot/${PN}.git"
	EGIT_BRANCH=master
else
	SRC_URI="https://github.com/keepassxreboot/keepassxc/releases/download/${PV}/keepassxc-${PV}-src.tar.xz -> ${P}.tar.xz"
fi

LICENSE="LGPL-2.1 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="autotype debug http test"

RDEPEND="
	lib-dev/libgcrypt
	xgui-live-lib/qtbase
	xgui-live-lib/qttools
	lib-sys/zlib
	lib-dev/libsodium
	app-crypt/argon2
	autotype? (
		xgui-live-lib/qtx11extras
		x11-live-lib/libX11
		x11-live-lib/libXi
		x11-live-lib/libXtst
	)
"

DEPEND="${RDEPEND}
	app-media/qrencode"

src_configure() {
	 use test || \
		sed -e "/^find_package(Qt5Test/d" -i CMakeLists.txt || die

	local mycmakeargs=(
		-DWITH_GUI_TESTS=OFF
		-DWITH_TESTS="$(usex test)"
		-DWITH_XC_AUTOTYPE="$(usex autotype)"
		-DWITH_XC_YUBIKEY=OFF
		-DKEEPASSXC_BUILD_TYPE_RELEASE=on
		-DWITH_XC_DOCS=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}
