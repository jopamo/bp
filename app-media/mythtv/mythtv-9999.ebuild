# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_7 )

inherit flag-o-matic python-single-r1 qmake-utils user systemd git-r3

MYTHTV_BRANCH="fixes/0.28"

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="https://www.mythtv.org"
EGIT_REPO_URI="https://github.com/MythTV/mythtv.git"

LICENSE="GPL-2"
KEYWORDS="amd64 arm64"
SLOT="0/${PV}"

IUSE_INPUT_DEVICES="input_devices_joystick"
IUSE="alsa altivec autostart bluray cec crystalhd debug dvb dvd egl fftw +hls \
	ieee1394 jack lcd libass lirc +mythlogserver perl pulseaudio python systemd +theora \
	vaapi vdpau +vorbis +wrapper +xml xmltv +xvid zeroconf ${IUSE_INPUT_DEVICES}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	bluray? ( xml )
	theora? ( vorbis )"

COMMON="
	lib-dev/glib:2
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtnetwork:5
	gui-lib/qtsql:5[mysql]
	gui-lib/qtopengl:5
	gui-lib/qtwebkit:5
	gui-lib/qtwidgets:5
	gui-lib/qtxml:5
	app-media/exiv2:=
	lib-media/freetype:2
	lib-media/taglib
	>=app-media/lame-3.93.1
	lib-sys/zlib
	virtual/mysql
	lib-media/mesa
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXv
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	x11-misc/wmctrl
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
	hls? (
		lib-media/faac
		<lib-media/libvpx-1.7.0:=
		>=lib-media/x264-0.0.20111220:=
	)
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
	theora? ( lib-media/libtheora lib-media/libogg )
	vaapi? ( x11-libs/libva:=[opengl] )
	vdpau? ( x11-libs/libvdpau )
	vorbis? ( >=lib-media/libvorbis-1.0 lib-media/libogg )
	xml? ( >=lib-dev/libxml2-2.6.0 )
	xvid? ( >=lib-media/xvid-1.1.0 )
	zeroconf? (
		lib-dev/openssl:0=
		lib-net/avahi[mdnsresponder-compat]
	)
"
RDEPEND="${COMMON}
	!media-tv/mythtv-bindings
	!x11-misc/mythtv-themes
	fonts/corefonts
	fonts/dejavu
	fonts/liberation-fonts
	x11-app/xinit
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
	x11-misc/xorg-proto
"

S="${WORKDIR}/${P}/mythtv"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="
To have this machine operate as recording host for MythTV,
mythbackend must be running. Run the following:
rc-update add mythbackend default

Your recordings folder must be owned 'mythtv'. e.g.
chown -R mythtv /var/lib/mythtv

Want mythfrontend to start automatically?
Set USE=autostart. Details can be found at:
https://dev.gentoo.org/~cardoe/mythtv/autostart.html

Note that the systemd unit now restarts by default and logs
to journald via the console at the notice verbosity.
"

MYTHTV_GROUPS="video,audio,tty,uucp"

pkg_setup() {
	python-single-r1_pkg_setup
	enewuser mythtv -1 /bin/bash /home/mythtv ${MYTHTV_GROUPS}
	usermod -a -G ${MYTHTV_GROUPS} mythtv
}

src_prepare() {
	default

	# Perl bits need to go into vender_perl and not site_perl
	sed -e "s:pure_install:pure_install INSTALLDIRS=vendor:" \
		-i "${S}"/bindings/perl/Makefile

	# Fix up the version info since we are using the fixes/${PV} branch
	echo "SOURCE_VERSION=\"v${MY_PV}\"" > "${S}"/VERSION
	echo "BRANCH=\"${MYTHTV_BRANCH}\"" >> "${S}"/VERSION
	echo "SOURCE_VERSION=\"${BACKPORTS}\"" > "${S}"/EXPORTED_VERSION
	echo "BRANCH=\"${MYTHTV_BRANCH}\"" >> "${S}"/EXPORTED_VERSION

	echo "setting.extra -= -ldconfig" >> "${S}"/programs/mythfrontend/mythfrontend.pro

	eapply "${FILESDIR}/${P}-glibc225.patch"
	eapply -p2 "${FILESDIR}/${PN}-29.2-freetype_pkgconfig.patch" #658534
	eapply "${FILESDIR}/${P}-qt511.patch"
}

src_configure() {
	local myconf=

	# Setup paths
	myconf="${myconf} --prefix=${EPREFIX}/usr"
	myconf="${myconf} --libdir=${EPREFIX}/usr/$(get_libdir)"
	myconf="${myconf} --libdir-name=$(get_libdir)"
	myconf="${myconf} --mandir=${EPREFIX}/usr/share/man"

	# Audio
	myconf="${myconf} $(use_enable alsa audio-alsa)"
	myconf="${myconf} $(use_enable jack audio-jack)"
	use pulseaudio || myconf="${myconf} --disable-audio-pulseoutput"

	use altivec    || myconf="${myconf} --disable-altivec"
	myconf="${myconf} $(use_enable dvb)"
	myconf="${myconf} $(use_enable ieee1394 firewire)"
	myconf="${myconf} $(use_enable lirc)"
	myconf="${myconf} $(use_enable xvid libxvid)"
	myconf="${myconf} --dvb-path=/usr/include"
	myconf="${myconf} --enable-xrandr"
	myconf="${myconf} --enable-xv"
	myconf="${myconf} --enable-x11"
	myconf="${myconf} --enable-nonfree"
	myconf="${myconf} --enable-libmp3lame"
	use cec || myconf="${myconf} --disable-libcec"
	use zeroconf || myconf="${myconf} --disable-libdns-sd"
	myconf="${myconf} $(use_enable theora libtheora)"
	myconf="${myconf} $(use_enable vorbis libvorbis)"

	if use hls; then
		myconf="${myconf} --enable-libx264"
		myconf="${myconf} --enable-libvpx"
		myconf="${myconf} --enable-libfaac"
	fi

	myconf="${myconf} $(use_enable libass)"

	if use perl && use python; then
		myconf="${myconf} --with-bindings=perl,python"
	elif use perl; then
		myconf="${myconf} --without-bindings=python"
		myconf="${myconf} --with-bindings=perl"
	elif use python; then
		myconf="${myconf} --without-bindings=perl"
		myconf="${myconf} --with-bindings=python"
	else
		myconf="${myconf} --without-bindings=perl,python"
	fi

	use python && myconf="${myconf} --python=${EPYTHON}"

	if use debug; then
		myconf="${myconf} --compile-type=debug"
	else
		myconf="${myconf} --compile-type=release"
		#myconf="${myconf} --enable-debug" does nothing per sphery
		myconf="${myconf} --disable-stripping" # FIXME: does not disable for all files, only for some
	fi

	# Video
	myconf="${myconf} $(use_enable vdpau)"
	myconf="${myconf} $(use_enable vaapi)"
	myconf="${myconf} $(use_enable crystalhd)"

	# Input
	use input_devices_joystick || myconf="${myconf} --disable-joystick-menu"

	# Clean up DSO load times and other compiler bits
	myconf="${myconf} --enable-symbol-visibility"
	myconf="${myconf} --enable-pic"

	# CPU settings
	for i in $(get-flag march) $(get-flag mcpu) $(get-flag mtune) ; do
		[ "${i}" = "native" ] && i="host"
		myconf="${myconf} --cpu=${i}"
		break
	done

	if tc-is-cross-compiler ; then
		myconf="${myconf} --enable-cross-compile --arch=$(tc-arch-kernel)"
		myconf="${myconf} --cross-prefix=${CHOST}-"
	fi

	# Build boosters
	has distcc ${FEATURES} || myconf="${myconf} --disable-distcc"
	has ccache ${FEATURES} || myconf="${myconf} --disable-ccache"

	myconf="${myconf} $(use_enable systemd systemd_notify)"
	use systemd || myconf="${myconf} $(use_enable mythlogserver)"

	chmod +x ./external/FFmpeg/version.sh

	einfo "Running ./configure ${myconf}"
	./configure \
		--cc="$(tc-getCC)" \
		--cxx="$(tc-getCXX)" \
		--ar="$(tc-getAR)" \
		--extra-cflags="${CFLAGS}" \
		--extra-cxxflags="${CXXFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		--qmake=$(qt5_get_bindir)/qmake \
		${myconf} || die "configure died"
}

src_install() {
	emake STRIP="true" INSTALL_ROOT="${D}" install
	dodoc AUTHORS UPGRADING README
	readme.gentoo

	insinto /usr/share/mythtv/database
	doins database/*

	newinitd "${FILESDIR}"/mythbackend.init-r2 mythbackend
	newconfd "${FILESDIR}"/mythbackend.conf-r1 mythbackend
	systemd_newunit "${FILESDIR}"/mythbackend.service-28 mythbackend.service

	dodoc keys.txt

	keepdir /etc/mythtv
	chown -R mythtv "${ED}"/etc/mythtv
	keepdir /var/log/mythtv
	chown -R mythtv "${ED}"/var/log/mythtv
	dodir /var/log/mythtv/old

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/mythtv.logrotate.d-r4 mythtv

	insinto /usr/share/mythtv/contrib
	# Ensure we don't install scripts needing the perl bindings (bug #516968)
	use perl || find contrib/ -name '*.pl' -exec rm -f {} \;
	# Ensure we don't install scripts needing the python bindings (bug #516968)
	use python || find contrib/ -name '*.py' -exec rm -f {} \;
	doins -r contrib/*

	# Install our mythfrontend wrapper which is similar to Mythbuntu's
	if use wrapper; then
		mv "${ED}/usr/bin/mythfrontend" "${ED}/usr/bin/mythfrontend.real"
		newbin "${FILESDIR}"/mythfrontend.wrapper mythfrontend
		newconfd "${FILESDIR}"/mythfrontend.conf mythfrontend
	fi

	if use autostart; then
		dodir /etc/env.d/
		echo 'CONFIG_PROTECT="/home/mythtv/"' > "${ED}"/etc/env.d/95mythtv

		insinto /home/mythtv
		newins "${FILESDIR}"/bash_profile .bash_profile
		newins "${FILESDIR}"/xinitrc-r1 .xinitrc
	fi

	# Make Python files executable
	find "${ED}/usr/share/mythtv" -type f -name '*.py' | while read file; do
		if [[ ! "${file##*/}" = "__init__.py" ]]; then
			chmod a+x "${file}"
		fi
	done

	# Ensure that Python scripts are executed by Python 2
	python_fix_shebang "${ED}/usr/share/mythtv"

	# Make shell & perl scripts executable
	find "${ED}" -type f -name '*.sh' -o -type f -name '*.pl' | \
		while read file; do
		chmod a+x "${file}"
	done
}

pkg_preinst() {
	export CONFIG_PROTECT="${CONFIG_PROTECT} ${EROOT}/home/mythtv/"
}

pkg_postinst() {
	readme.gentoo
}

pkg_info() {
	if [[ -f "${EROOT}"/usr/bin/mythfrontend ]]; then
		"${EROOT}"/usr/bin/mythfrontend --version
	fi
}

pkg_config() {
	echo "Creating mythtv MySQL user and mythconverg database if it does not"
	echo "already exist. You will be prompted for your MySQL root password."
	"${EROOT}"/usr/bin/mysql -u root -p < "${EROOT}"/usr/share/mythtv/database/mc.sql
}
