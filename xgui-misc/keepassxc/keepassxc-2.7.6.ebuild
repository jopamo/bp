# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg flag-o-matic

DESCRIPTION="KeePassXC - KeePass Cross-platform Community Edition"
HOMEPAGE="https://keepassxc.org"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/keepassxreboot/${PN}.git"
	EGIT_BRANCH="release/$(ver_cut 1-2).x"
else
	SRC_URI="https://github.com/keepassxreboot/keepassxc/releases/download/${PV}/keepassxc-${PV}-src.tar.xz -> ${P}.tar.xz"
fi

LICENSE="LGPL-2.1 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="autotype test"

DEPEND="
	app-crypto/argon2
	app-crypto/botan
	lib-core/libgcrypt
	lib-core/zlib
	lib-live/libsodium
	xgui-lib/qtbase
	xgui-lib/qttools
	xmedia-live-app/qrencode
	autotype? (
		xgui-live-lib/libX11
		xgui-live-lib/libXi
		xgui-live-lib/libXtst
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
	)
	cmake_src_configure
}
