# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg flag-o-matic

DESCRIPTION="KeePassXC - KeePass Cross-platform Community Edition"
HOMEPAGE="https://keepassxc.org"
SRC_URI="https://github.com/keepassxreboot/keepassxc/releases/download/${PV}/keepassxc-${PV}-src.tar.xz -> ${P}.tar.xz"

LICENSE="LGPL-2.1 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+autotype test"

DEPEND="
	app-crypto/argon2
	app-crypto/botan
	lib-core/libgcrypt
	lib-core/zlib
	lib-util/libsodium
	xgui-lib/qtbase
	xgui-lib/qttools
	xgui-lib/qtsvg
	xmedia-app/qrencode
	autotype? (
		xgui-lib/libX11
		xgui-lib/libXi
		xgui-lib/libXtst
	)
"

src_configure() {
	filter-flags -flto*

	 use test || \
		sed -e "/^find_package(Qt5Test/d" -i CMakeLists.txt || die

	local mycmakeargs=(
		-DKEEPASSXC_BUILD_TYPE_RELEASE=on
		-DWITH_GUI_TESTS=OFF
		-DWITH_TESTS="$(usex test)"
		-DWITH_XC_AUTOTYPE="$(usex autotype)"
		-DWITH_XC_DOCS=OFF
		-DWITH_XC_YUBIKEY=OFF
		-DWITH_XC_SSHAGENT=ON
		-DWITH_XC_BROWSER=ON
		-DWITH_XC_BROWSER_PASSKEYS=ON
		-DWITH_XC_NETWORKING=OFF
		-DWITH_XC_UPDATECHECK=OFF
	)
	cmake_src_configure
}
