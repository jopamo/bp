# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=8da89f8493b21ebfbe344a54dbef0cde23c7ea59
SNAPSHOT2="f1936f02ba06b5012f89f75901944e8c2d26951c"

inherit flag-o-matic xdg

DESCRIPTION="Compatibility layer capable of running Windows applications"
HOMEPAGE="https://www.winehq.org/"

SRC_URI="
	https://github.com/wine-mirror/wine/archive/${SNAPSHOT}.tar.gz -> wine-${SNAPSHOT}.tar.gz
	https://github.com/wine-staging/wine-staging/archive/${SNAPSHOT2}.tar.gz -> wine-staging-${SNAPSHOT2}.tar.gz
"

S="${WORKDIR}/wine-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa cups custom-cflags fontconfig netapi nls odbc opencl
 +opengl perl pcap prelink pulseaudio samba +staging test +X +xcomposite
 xinerama usb"

RESTRICT="test"

DEPEND="
	X? (
		xgui-lib/libXcursor
		xgui-lib/libXext
		xgui-lib/libXfixes
		xgui-lib/libXrandr
		xgui-lib/libXi
		xgui-lib/libXxf86vm
	)
	alsa? ( xgui-tools/alsa-lib )
	cups? ( lib-print/cups )
	fontconfig? ( fonts/fontconfig )
	netapi? ( app-server/samba )
	opengl? (
		xmedia-lib/glu
		xgui-tools/mesa
	)
	pcap? ( lib-net/libpcap )
	perl? (	app-lang/perl )
	pulseaudio? ( xmedia-lib/pulseaudio )
	samba? ( app-server/samba[winbind] )
	xcomposite? ( xgui-lib/libXcomposite )
	xinerama? ( xgui-lib/libXinerama )
	usb? (	lib-dev/libusb )
"
BDEPEND="
	app-build/autoconf
	app-build/flex
	app-dev/pkgconf
	app-build/bison
	X? ( xgui-tools/xorgproto )
"

PATCHES=(
	"${FILESDIR}/wine-20260821-builtin-clear-cache.patch"
)

src_prepare() {
	filter-flags -flto* -Wl,-z,defs

	default

	"${WORKDIR}/wine-staging-${SNAPSHOT2}/staging/patchinstall.py" \
		DESTDIR="${S}" --all --no-autoconf || die
	# Regenerate for both local and staging patches, and check for failures.
	autoreconf -f || die
	./tools/make_requests || die
}

src_configure() {
	local myconf=(
		--enable-win64
		$(use_with cups)
		$(use_with fontconfig)
		$(use_with netapi)
		$(use_with opengl)
		$(use_with pcap)
		$(use_with pulseaudio pulse)
		$(use_with usb)
		$(use_with xcomposite)
		$(use_with xinerama)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	# Host ELF strip cannot process Wine's PE/COFF libraries.
	local dir
	for dir in "${ED}"/usr/lib/wine/*-windows; do
		[[ -d ${dir} ]] || continue
		dostrip -x "${dir#"${ED}"}"
	done
}
