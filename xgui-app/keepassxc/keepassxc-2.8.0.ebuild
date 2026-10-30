# Distributed under the terms of the GNU General Public License v2

inherit cmake xdg flag-o-matic

DESCRIPTION="KeePassXC - KeePass Cross-platform Community Edition"
HOMEPAGE="https://keepassxc.org"
SRC_URI="https://github.com/keepassxreboot/keepassxc/releases/download/${PV}/keepassxc-${PV}-src.tar.xz -> ${P}.tar.xz"

LICENSE="LGPL-2.1 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="autotype test"

DEPEND="
	app-compression/libzip:=
	app-crypto/vesk
	app-crypto/botan
	app-crypto/keyutils
	app-crypto/pcsc-lite
	lib-core/zlib
	lib-core/libsodium
	lib-dev/libusb
	xgui-lib/libxkbcommon
	xgui-lib/qtbase:6
	xgui-lib/qttools:6
	xgui-lib/qtsvg:6
	xmedia-app/qrencode
	autotype? (
		xgui-lib/libX11
		xgui-lib/libXi
		xgui-lib/libXtst
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/optional-qt-accessibility.patch"
	"${FILESDIR}/libzip.patch"
)

src_prepare() {
	sed -i 's/\r$//' src/keeshare/Share{Import,Export}.cpp || die
	cmake_src_prepare
}

src_configure() {
	filter-flags -flto*

	local mycmakeargs=(
		-DKEEPASSXC_BUILD_TYPE_RELEASE=on
		-DWITH_GUI_TESTS=OFF
		-DWITH_TESTS="$(usex test)"
		-DWITH_X11="$(usex autotype)"
		-DKPXC_FEATURE_DOCS=OFF
		-DKPXC_FEATURE_SSHAGENT=ON
		-DKPXC_FEATURE_BROWSER=ON
		-DKPXC_FEATURE_FDOSECRETS=OFF
		-DKPXC_FEATURE_NETWORK=OFF
		-DKPXC_FEATURE_UPDATES=OFF
	)
	cmake_src_configure
}
