# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit qt5-build

DESCRIPTION="Multimedia (audio, video, radio, camera) library for the Qt5 framework"
KEYWORDS="amd64 arm64"

IUSE="alsa gles2 gstreamer openal pulseaudio qml widgets"

RDEPEND="
	~gui-lib/qtcore-${PV}
	~gui-lib/qtgui-${PV}[gles2=]
	~gui-lib/qtnetwork-${PV}
	alsa? ( lib-media/alsa-lib )
	gstreamer? (
		lib-dev/glib:2
		lib-media/gstreamer:1.0
		lib-media/gst-plugins-bad:1.0
		lib-media/gst-plugins-base:1.0
	)
	pulseaudio? ( app-media/pulseaudio )
	qml? (
		~gui-lib/qtdeclarative-${PV}
		gles2? ( ~gui-lib/qtgui-${PV}[egl] )
		openal? ( lib-media/openal )
	)
	widgets? (
		~gui-lib/qtopengl-${PV}
		~gui-lib/qtwidgets-${PV}[gles2=]
	)
"
DEPEND="${RDEPEND}
	gstreamer? ( x11-proto/videoproto )
"

src_prepare() {
	sed -i -e '/CONFIG\s*+=/ s/optimize_full//' \
		src/multimedia/multimedia.pro || die

	qt_use_disable_config openal openal \
		src/imports/imports.pro

	qt_use_disable_mod qml quick \
		src/src.pro \
		src/plugins/plugins.pro

	qt_use_disable_mod widgets widgets \
		src/src.pro \
		src/gsttools/gsttools.pro \
		src/plugins/gstreamer/common.pri

	qt5-build_src_prepare
}

src_configure() {
	local myqmakeargs=(
		--
		$(qt_use alsa)
		$(qt_use gstreamer)
		$(qt_use pulseaudio)
	)
	qt5-build_src_configure
}
