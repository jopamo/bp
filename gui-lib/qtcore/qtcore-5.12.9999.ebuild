# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
inherit qt5-build

DESCRIPTION="Cross-platform application development framework"
KEYWORDS="amd64 arm64"

IUSE="icu systemd"

DEPEND="
	lib-dev/double-conversion:=
	lib-dev/glib:2
	lib-dev/libpcre2[pcre16,unicode]
	lib-sys/zlib
	icu? ( lib-dev/icu:= )
	systemd? ( sys-app/systemd:= )
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/tools/bootstrap
	src/tools/moc
	src/tools/rcc
	src/tools/qfloat16-tables
	src/corelib
	src/tools/qlalr
	doc
)

QT5_GENTOO_PRIVATE_CONFIG=(
	!:network
	!:sql
	!:testlib
	!:xml
)

filter-flags -flto

#src_prepare() {
#	git apply -R ${FILESDIR}/1c0fcbc887459d8963088309e83303eb1a7d2db0.patch
#	eapply_user
#}

src_configure() {
	local myconf=(
		$(qt_use icu)
		$(qt_use !icu iconv)
		$(qt_use systemd journald)
	)
	qt5-build_src_configure
}

src_install() {
	qt5-build_src_install

	local flags=(
		ALSA CUPS DBUS EGL EGLFS EGL_X11 EVDEV FONTCONFIG FREETYPE
		HARFBUZZ IMAGEFORMAT_JPEG IMAGEFORMAT_PNG LIBPROXY MITSHM
		OPENGL OPENSSL OPENVG PULSEAUDIO SHAPE SSL TSLIB WIDGETS
		XCURSOR	XFIXES XKB XRANDR XRENDER XSYNC ZLIB
	)

	for flag in ${flags[@]}; do
		cat >> "${D%/}"/${QT5_HEADERDIR}/QtCore/qconfig.h <<- _EOF_ || die

			#if defined(QT_NO_${flag}) && defined(QT_${flag})
			# undef QT_NO_${flag}
			#elif !defined(QT_NO_${flag}) && !defined(QT_${flag})
			# define QT_NO_${flag}
			#endif
		_EOF_
	done
}
