# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools cmake-utils eutils versionator git-r3

DESCRIPTION="A free and open source media-player and entertainment hub"
HOMEPAGE="https://kodi.tv/ https://kodi.wiki/"
EGIT_REPO_URI="https://github.com/xbmc/xbmc.git"

KEYWORDS="amd64 arm64 x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="airplay alsa bluetooth bluray caps cec +css dbus debug dvd gles lcms libressl libusb lirc mariadb mysql nfs nonfree +opengl pulseaudio samba sftp systemd test +udev udisks upnp upower vaapi vdpau webserver +xslt zeroconf"

REQUIRED_USE="
	|| ( gles opengl )
	?? ( mariadb mysql )
	udev? ( !libusb )
	udisks? ( dbus )
	upower? ( dbus )
"

COMMON_DEPEND=">=lib-media/libass-0.13.4
	lib-dev/libcdio
	alsa? ( lib-media/alsa-lib )
	bluetooth? ( app-net/bluez )
	bluray? ( >=lib-media/libbluray-0.7.0 )
	caps? ( lib-sys/libcap )
	dbus? ( sys-app/dbus )
	lib-sys/sqlite
	lib-dev/expat
	lib-dev/fribidi
	cec? ( >=lib-dev/libcec-4.0 )
	lib-dev/libpcre[cxx]
	lib-dev/libxml2
	>=lib-dev/lzo-2.04
	lib-dev/libfstrcmp
	lib-media/taglib
	lib-dev/tinyxml
	lib-dev/libcdio
	gles? ( lib-media/mesa[gles2] )
	lcms? ( lib-media/lcms:2 )
	libusb? ( virtual/libusb:1 )
	fonts/liberation-fonts
	lib-media/fontconfig
	lib-media/freetype
	lib-dev/rapidjson
	lib-dev/libfmt
	lib-media/mesa[egl]
	app-media/ffmpeg
	mysql? ( dev-db/mysql-connector-c:= )
	mariadb? ( app-server/mariadb-connector-c:=[mysqlcompat] )
	>=app-net/curl-7.51.0
	nfs? ( sys-app/libnfs:= )
	opengl? ( lib-media/glu )
	!libressl? ( >=lib-dev/openssl-1.0.2j:0= )
	libressl? ( lib-dev/libressl:0= )
	pulseaudio? ( app-media/pulseaudio )
	samba? ( >=sys-app/samba-3.4.6[smbclient(+)] )
	sftp? ( lib-net/libssh[sftp] )
	lib-sys/zlib
	udev? ( sys-app/systemd )
	vaapi? ( x11-libs/libva:=[opengl] )
	vdpau? (
		|| ( >=x11-libs/libvdpau-1.1 >=x11-misc/nvidia-drivers-180.51 )
		 app-media/ffmpeg[vdpau]
	)
	webserver? ( >=lib-net/libmicrohttpd-0.9.50[messages] )
	xslt? ( lib-dev/libxslt )
"

RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}
	app-compression/bzip2
	app-compression/xz-utils
	dev-lang/swig
	lib-dev/crossguid
	dev-util/cmake
	dev-util/gperf
	lib-dev/flatbuffers
	lib-media/giflib
	>=lib-media/libjpeg-turbo-1.5.1:=
	>=lib-media/libpng-1.6.26:0=
	test? ( dev-cpp/gtest )
	dev-util/pkgconfig
	x86? ( dev-lang/nasm )
"

src_prepare() {
	cmake-utils_src_prepare

	# Prepare tools and libs witch are configured with autotools during compile time
	AUTOTOOLS_DIRS=(
		"${S}"/lib/cpluff
		"${S}"/tools/depends/native/TexturePacker/src
		"${S}"/tools/depends/native/JsonSchemaBuilder/src
	)

	local d
	for d in "${AUTOTOOLS_DIRS[@]}" ; do
		pushd ${d} >/dev/null || die
		AT_NOELIBTOOLIZE="yes" AT_TOPLEVEL_EAUTORECONF="yes" eautoreconf
		popd >/dev/null || die
	done
	elibtoolize

	# Prevent autoreconf rerun
	sed -e 's/autoreconf -vif/echo "autoreconf already done in src_prepare()"/' -i \
		"${S}"/cmake/modules/FindCpluff.cmake \
		"${S}"/tools/depends/native/TexturePacker/src/autogen.sh \
		"${S}"/tools/depends/native/JsonSchemaBuilder/src/autogen.sh \
		|| die
}

src_configure() {
	local mycmakeargs=(
		-Ddocdir="${EPREFIX}/usr/share/doc/${PF}"
		-DENABLE_LDGOLD=OFF
		-DENABLE_ALSA=$(usex alsa)
		-DENABLE_AIRTUNES=$(usex airplay)
		-DENABLE_AVAHI=$(usex zeroconf)
		-DENABLE_BLUETOOTH=$(usex bluetooth)
		-DENABLE_BLURAY=$(usex bluray)
		-DENABLE_CCACHE=OFF
		-DENABLE_CEC=$(usex cec)
		-DENABLE_DBUS=$(usex dbus)
		-DENABLE_DVDCSS=$(usex css)
		-DENABLE_INTERNAL_CROSSGUID=ON
		-DENABLE_INTERNAL_FFMPEG=ON
		-DENABLE_CAP=$(usex caps)
		-DENABLE_LCMS2=$(usex lcms)
		-DENABLE_LIRC=$(usex lirc)
		-DENABLE_MICROHTTPD=$(usex webserver)
		-DENABLE_NFS=$(usex nfs)
		-DENABLE_NONFREE=$(usex nonfree)
		-DENABLE_OPENGLES=$(usex gles)
		-DENABLE_OPENGL=$(usex opengl)
		-DENABLE_OPENSSL=ON
		-DENABLE_OPTICAL=$(usex dvd)
		-DENABLE_PLIST=$(usex airplay)
		-DENABLE_PULSEAUDIO=$(usex pulseaudio)
		-DENABLE_SMBCLIENT=$(usex samba)
		-DENABLE_SSH=$(usex sftp)
		-DENABLE_UDEV=$(usex udev)
		-DENABLE_UPNP=$(usex upnp)
		-DENABLE_VAAPI=$(usex vaapi)
		-DENABLE_VDPAU=$(usex vdpau)
		-DENABLE_X11=ON
		-DENABLE_XSLT=$(usex xslt)
		-DLTO_OPTIMIZATION=OFF
	)

	if use mysql || use mariadb ; then
		mycmakeargs+=( -DENABLE_MYSQLCLIENT="yes" )
	else
		mycmakeargs+=( -DENABLE_MYSQLCLIENT="no" )
	fi

	use libusb && mycmakeargs+=( -DENABLE_LIBUSB=$(usex libusb) )

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile all
	use test && emake -C "${BUILD_DIR}" kodi-test
}

src_test() {
	emake -C "${BUILD_DIR}" test
}

src_install() {
	cmake-utils_src_install
	rm -rf "${ED}"/usr/share/doc || die
}
