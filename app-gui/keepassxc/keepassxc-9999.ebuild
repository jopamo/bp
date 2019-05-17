# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils xdg-utils

DESCRIPTION="KeePassXC - KeePass Cross-platform Community Edition"
HOMEPAGE="https://keepassxc.org"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/keepassxreboot/${PN}.git"
	EGIT_BRANCH=master
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://github.com/keepassxreboot/keepassxc/releases/download/${PV}/keepassxc-${PV}-src.tar.xz -> ${P}.tar.xz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="LGPL-2.1 GPL-2 GPL-3"
SLOT="0"
IUSE="autotype debug http test"

RDEPEND="
	lib-dev/libgcrypt:=
	gui-lib/qtcore
	gui-lib/qtdbus
	gui-lib/qtgui
	gui-lib/qtnetwork
	gui-lib/qtwidgets
	gui-lib/qttest
	lib-sys/zlib
	app-crypt/argon2
	autotype? (
		gui-lib/qtx11extras
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXtst
	)
"

DEPEND="
	${RDEPEND}
	gui-lib/linguist-tools:5
	gui-lib/qtconcurrent:5
	app-media/qrencode
	test? ( gui-lib/qttest:5 )
"

src_prepare() {
	 use test || \
		sed -e "/^find_package(Qt5Test/d" -i CMakeLists.txt || die

	 cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_GUI_TESTS=OFF
		-DWITH_TESTS="$(usex test)"
		-DWITH_XC_AUTOTYPE="$(usex autotype)"
		-DWITH_XC_YUBIKEY=OFF
		-DKEEPASSXC_BUILD_TYPE_RELEASE=on
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
