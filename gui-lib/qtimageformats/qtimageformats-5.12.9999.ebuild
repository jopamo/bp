# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt5-build

DESCRIPTION="Additional format plugins for the Qt image I/O system"
KEYWORDS="amd64 arm64"

IUSE="mng"

DEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}
	lib-media/libwebp:=
	lib-media/tiff:0
	mng? ( lib-media/libmng:= )
"
RDEPEND="${DEPEND}"

src_configure() {
	qt_use_compile_test mng libmng
	qt5-build_src_configure
}
