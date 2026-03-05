# Copyright 2026
# Distributed under GPL-2

EAPI=8

inherit check-reqs desktop udev xdg

PKG_NAME="DaVinci_Resolve_Studio_${PV}_Linux"
PKG_HOME="/opt/resolve"
PKG_MOUNT="squashfs-root"

DESCRIPTION="Professional A/V post-production suite from Blackmagic Design"
HOMEPAGE="https://www.blackmagicdesign.com/products/davinciresolve"

SRC_URI="${PKG_NAME}.zip"

S="${WORKDIR}"

LICENSE="Blackmagic"
SLOT="0"
KEYWORDS="~amd64"

IUSE="
bundled-libs
developer
video_cards_amdgpu
video_cards_nvidia
"

RESTRICT="fetch mirror strip test"

QA_PREBUILT="*"

DEPEND="
app-compression/brotli
app-compression/lz4

app-crypto/mit-krb5

lib-core/glib
lib-dev/icu
app-build/libtool
lib-dev/nspr
lib-dev/nss

xgui-lib/harfbuzz
xmedia-lib/libpng

app-core/dbus
app-build/gcc

xmedia-lib/libglvnd
app-dev/opencl-headers

xgui-lib/libX11
xgui-lib/libXext
xgui-lib/libXfixes
xgui-lib/libXrandr
xgui-lib/libXrender
xgui-lib/libXtst
xgui-lib/libxcb

!bundled-libs? (
    lib-net/avahi
    app-net/curl
    xgui-lib/freeglut
    xmedia-lib/soxr
    app-server/postgresql
)

video_cards_amdgpu? (
    xgui-tools/mesa
)

video_cards_nvidia? (
    bin/nvidia-drivers
)
"

RDEPEND="${DEPEND}"

BDEPEND="
app-compression/unzip
app-dev/patchelf
"

LIBS_SYM="
DaVinci Control Panels Setup/libavahi-common.so.3
DaVinci Control Panels Setup/libavahi-client.so.3
DaVinci Control Panels Setup/libdns_sd.so.1
libs/libapr-1.so
libs/libaprutil-1.so
libs/libcrypto.so.1.1
libs/libcurl.so
libs/liborc-0.4.so
libs/libpq.so.5
libs/libsoxr.so
libs/libsrtp2.so
libs/libssl.so.1.1
libs/libtbb.so.2
libs/libtbbmalloc.so.2
libs/libxmlsec1.so
"

pkg_pretend() {
	CHECKREQS_DISK_BUILD="24G"
	check-reqs_pkg_pretend
}

pkg_setup() {
	CHECKREQS_DISK_BUILD="24G"
	check-reqs_pkg_setup
}

src_unpack() {
	default

	# extract AppImage payload
	./${PKG_NAME}.run --appimage-extract || die
}

src_prepare() {
	default

	cd "${PKG_MOUNT}" || die

	sed -i \
	-e "s|RESOLVE_INSTALL_LOCATION|${PKG_HOME}|g" \
	share/*.desktop share/*.directory || die

	sed -i \
	-e "s|=Video|=AudioVideo|g" \
	share/*.desktop || die

	# remove old glib stack bundled by BMD
	rm -f libs/{libgio*,libglib*,libgmodule*,libgobject*} || die

	# krb symbol conflict
	rm -f "DaVinci Control Panels Setup"/libk5crypto.so.3 || die

	# sqlite linked to ncurses5
	rm -f bin/sqlite3 || die

	rm -rf libs/pkgconfig || die

	if ! use bundled-libs; then

		while read -r lib; do
			[[ -n "${lib}" ]] && rm -f "${lib}"
		done <<< "${LIBS_SYM}"

		rm -rf libs/graphviz || die

		find . -name "libgcc_s.so.1" -delete || die
		find . -name "libusb*" -delete || die
	fi

	rm -f \
	"BlackmagicRAWSpeedTest/Third Party Licenses.rtf" \
	"BlackmagicRAWPlayer/Third Party Licenses.rtf" || die
}

include_dir() {

	local dir="$1"

	doins -r "${dir}" || die

	find "${dir}" -type f -executable \
		-exec fperms +x "${PKG_HOME}/{}" \;
}

src_install() {

	cd "${PKG_MOUNT}" || die

	while IFS= read -r -d '' bin; do

		[[ -f "${bin}" ]] || continue

		patchelf --set-rpath \
		"${PKG_HOME}/libs:${PKG_HOME}/bin:\$ORIGIN" \
		"${bin}" || die

	done < <(find . -type f -size -32M -print0)

	insinto "${PKG_HOME}"

	for d in \
	bin \
	libs \
	Fusion \
	graphics \
	plugins \
	BlackmagicRAWPlayer \
	BlackmagicRAWSpeedTest \
	"DaVinci Control Panels Setup" \
	"Fairlight Studio Utility" \
	LUT \
	UI_Resource
	do
		include_dir "${d}"
	done

	if use developer; then
		include_dir Developer
	fi

	insinto "${PKG_HOME}/share"
	doins share/* || die

	dodoc docs/* || die

	insinto "$(get_udevdir)/rules.d"
	doins share/etc/udev/rules.d/*.rules || die

	insinto /usr/share/mime/packages
	doins share/*.xml || die

	newmenu share/DaVinciResolve.desktop com.blackmagicdesign.resolve.desktop

	newicon graphics/DV_Resolve.png DaVinci-Resolve.png

	keepdir "${PKG_HOME}"/{configs,logs,GPUCache,Media}

	keepdir /var/BlackmagicDesign/DaVinci\ Resolve

	# wrapper script
	exeinto /usr/bin
	newexe "${FILESDIR}/resolve-wrapper" resolve

	echo "SEARCH_DIRS=\"${PKG_HOME}\"" > "${T}/80${PN}" || die

	insinto /etc/revdep-rebuild
	doins "${T}/80${PN}"
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	udev_reload
	xdg_pkg_postinst
}

pkg_postrm() {
	udev_reload
	xdg_pkg_postrm
}
