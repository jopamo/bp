# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="kde/$(ver_cut 1-2)"

inherit qmake-utils

DESCRIPTION="Multimedia (audio, video, radio, camera) library for the Qt5 framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=ff83d119c75cd8406f73ccc08958fe36747e7390
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase:$(ver_cut 1)"

src_prepare() {
	default

	sed -i \
		-e 's/^void QT_FASTCALL qt_convert_BGRA32_to_ARGB32_ssse3/QT_FUNCTION_TARGET(SSSE3) void QT_FASTCALL qt_convert_BGRA32_to_ARGB32_ssse3/' \
		src/multimedia/video/qvideoframeconversionhelper_ssse3.cpp || die
	sed -i \
		-e 's/^void QT_FASTCALL qt_convert_BGRA32_to_ARGB32_avx2/QT_FUNCTION_TARGET(AVX2) void QT_FASTCALL qt_convert_BGRA32_to_ARGB32_avx2/' \
		src/multimedia/video/qvideoframeconversionhelper_avx2.cpp || die

	local qtver
	qtver="$("$(qt5_get_bindir)"/qmake -query QT_VERSION)" || die
	"$(qt5_get_bindir)"/syncqt.pl -version "${qtver}" -outdir "${S}" "${S}" || die
}

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
