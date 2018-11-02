# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic qmake-utils user systemd git-r3

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="https://www.mythtv.org"
EGIT_REPO_URI="https://github.com/MythTV/mythtv.git"

LICENSE="GPL-2"
KEYWORDS="amd64 arm64"
SLOT="0/${PV}"

IUSE_INPUT_DEVICES="input_devices_joystick"
IUSE="alsa altivec autostart bluray cec crystalhd debug dvb dvd egl fftw +hls \
	ieee1394 jack lcd libass lirc +mythlogserver perl pulseaudio python systemd \
	vaapi vdpau +wrapper +xml xmltv ${IUSE_INPUT_DEVICES}"

COMMON="
	lib-dev/glib:2
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtnetwork:5
	gui-lib/qtsql:5[mysql]
	gui-lib/qtopengl:5
	gui-lib/qtwidgets:5
	gui-lib/qtxml:5
	app-media/exiv2:=
	lib-media/freetype:2
	lib-media/taglib
	>=app-media/lame-3.93.1
	lib-sys/zlib
	app-server/mariadb
	lib-media/mesa
	dev-lang/ruby
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXv
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	alsa? ( >=lib-media/alsa-lib-1.0.24 )
	bluray? (
		lib-dev/libcdio:=
		lib-media/libbluray:=
		sys-fs/udisks:2
	)
	cec? ( lib-dev/libcec )
	dvb? (
		virtual/linuxtv-dvb-headers
	)
	dvd? (
		lib-dev/libcdio:=
		sys-fs/udisks:2
	)
	egl? ( lib-media/mesa[egl] )
	fftw? ( sci-libs/fftw:3.0= )
	ieee1394? (
		>=lib-media/libiec61883-1.0.0
		>=lib-sys/libavc1394-0.5.3
		>=lib-sys/libraw1394-1.2.0
	)
	jack? ( app-media/jack-audio-connection-kit )
	lcd? ( app-misc/lcdproc )
	libass? ( >=lib-media/libass-0.9.11:= )
	lirc? ( app-misc/lirc )
	perl? (
		>=dev-perl/libwww-perl-5
		dev-perl/DBD-mysql
		dev-perl/HTTP-Message
		dev-perl/IO-Socket-INET6
		dev-perl/LWP-Protocol-https
		dev-perl/Net-UPnP
	)
	pulseaudio? ( app-media/pulseaudio )
	python? (
		${PYTHON_DEPS}
		dev-python/lxml
		dev-python/mysql-python
		dev-python/urlgrabber
	)
	systemd? ( sys-app/systemd:= )
	vaapi? ( x11-libs/libva:=[opengl] )
	vdpau? ( x11-libs/libvdpau )
	xml? ( >=lib-dev/libxml2-2.6.0 )
"
RDEPEND="${COMMON}
	!media-tv/mythtv-bindings
	!x11-misc/mythtv-themes
	fonts/liberation-fonts
	autostart? (
		net-dialup/mingetty
		x11-app/xset
		x11-misc/evilwm
	)
	dvd? ( lib-media/libdvdcss )
	xmltv? ( >=media-tv/xmltv-0.5.43 )
"
DEPEND="${COMMON}
	dev-lang/yasm
	dev-util/pkgconfig
"

S="${WORKDIR}/${P}/mythtv"

MYTHTV_GROUPS="video,audio,tty,uucp"

pkg_setup() {
	enewuser mythtv -1 /bin/bash /home/mythtv ${MYTHTV_GROUPS}
	usermod -a -G ${MYTHTV_GROUPS} mythtv
}

src_configure() {
	${S}/configure \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--shlibdir="${EPREFIX}/usr/$(get_libdir)" \
		--disable-qtwebkit \
		--disable-libbluray_external \
		--cc="$(tc-getCC)" \
		--cxx="$(tc-getCXX)" \
		--ar="$(tc-getAR)" \
		--extra-cflags="${CFLAGS}" \
		--extra-cxxflags="${CXXFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		--qmake=$(qt5_get_bindir)/qmake \
		$(use_enable systemd mythlogserver) \
		$(use_enable systemd systemd_notify) \
		--disable-joystick-menu \
		--compile-type=release \
		--enable-nonfree \
		--enable-pic \
		--enable-x11 \
		$(use_enable vdpau) \
		$(use_enable vaapi) \
		$(use_enable crystalhd) \
		--disable-libdns-sd \
		$(use_enable libass)
}

src_install() {
	emake STRIP="true" INSTALL_ROOT="${D}" install

	insinto /usr/share/mythtv/database
	doins database/*

	systemd_newunit "${FILESDIR}"/mythbackend.service-28 mythbackend.service
}
