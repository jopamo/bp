# Copyright 2026
# Distributed under GPL-2

inherit desktop doins xdg

PKG_NAME="DaVinci_Resolve_Studio_${PV}_Linux"
PKG_HOME="/opt/resolve"
PKG_MOUNT="squashfs-root"

DESCRIPTION="Professional A/V post-production suite from Blackmagic Design"
HOMEPAGE="https://www.blackmagicdesign.com/products/davinciresolve"

SRC_URI="${PKG_NAME}.zip"

S="${WORKDIR}"

LICENSE="Blackmagic"
SLOT="0"
KEYWORDS="amd64"

IUSE="
+bundled-libs
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

app-core/dbus
app-core/util-linux
app-dev/opencl-headers
app-net/curl
app-server/postgresql
lib-core/glib
lib-core/libxcrypt-compat
lib-net/avahi
lib-dev/icu
app-build/libtool
lib-dev/nspr
lib-dev/nss

xgui-lib/harfbuzz
xgui-lib/freeglut
xgui-lib/libSM
xgui-lib/librsvg
xmedia-lib/libpng

app-build/gcc

xmedia-lib/libglvnd

xgui-lib/libX11
xgui-lib/libXext
xgui-lib/libXfixes
xgui-lib/libXrandr
xgui-lib/libXrender
xgui-lib/libXtst
xgui-lib/libXxf86vm
xgui-lib/libxcb

!bundled-libs? (
    lib-dev/libusb
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
app-compression/libarchive
app-dev/patchelf
"

PAYLOAD_DIRS="
Apple Immersive
BlackmagicRAWPlayer
BlackmagicRAWSpeedTest
Certificates
Control
DaVinci Control Panels Setup
Fairlight Studio Utility
Fusion
LUT
Onboarding
Technical Documentation
UI_Resource
bin
graphics
libs
plugins
scripts
share
"

OPTIONAL_PAYLOAD_DIRS="
Developer
"

UNBUNDLED_LIBS="
Fairlight Studio Utility/libavahi-client.so.3
Fairlight Studio Utility/libavahi-common.so.3
Fairlight Studio Utility/libdns_sd.so.1
"

src_unpack() {
	mkdir -p "${WORKDIR}" || die
	cd "${WORKDIR}" || die

	bsdtar -xf "${DISTDIR}/${PKG_NAME}.zip" || die
	chmod +x "./${PKG_NAME}.run" || die

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

	rm -f share/DaVinciResolveInstaller.desktop || die
	sed -i \
	-e '/resolve-Installer\.desktop/d' \
	share/DaVinciResolve.menu || die

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
		done <<< "${UNBUNDLED_LIBS}"

		find . -name "libgcc_s.so.1" -delete || die
		find . -name "libusb-1.0.so*" -delete || die
	fi

	rm -f \
	"BlackmagicRAWSpeedTest/Third Party Licenses.rtf" \
	"BlackmagicRAWPlayer/Third Party Licenses.rtf" || die
}

patch_elf_rpaths() {
	local root="${1:-.}"
	local elf

	while IFS= read -r -d '' elf; do
		LC_ALL=C file -b "${elf}" | grep -q '^ELF' || continue

		patchelf --set-rpath \
			"${PKG_HOME}/libs:${PKG_HOME}/bin:\$ORIGIN" \
			"${elf}" || die
	done < <(find "${root}" -type f -print0)
}

install_payload_path() {
	local path="$1"

	cp -a --no-preserve=ownership -- "${path}" "${ED}${PKG_HOME}/" \
		|| die "failed installing ${path}"
}

src_install() {

	cd "${PKG_MOUNT}" || die

	patch_elf_rpaths
	dodir "${PKG_HOME}"

	while read -r d; do
		[[ -n "${d}" ]] || continue
		install_payload_path "${d}"
	done <<< "${PAYLOAD_DIRS}"

	if use developer; then
		while read -r d; do
			[[ -n "${d}" ]] || continue
			install_payload_path "${d}"
		done <<< "${OPTIONAL_PAYLOAD_DIRS}"
	fi

	dodoc docs/* || die

	insinto "$(get_udevdir)/rules.d"
	doins share/etc/udev/rules.d/*.rules || die

	insinto /usr/share/mime/packages
	doins share/*.xml || die

	newmenu share/DaVinciResolve.desktop com.blackmagicdesign.resolve.desktop
	newmenu share/DaVinciResolveCaptureLogs.desktop com.blackmagicdesign.resolve-CaptureLogs.desktop
	newmenu share/DaVinciControlPanelsSetup.desktop com.blackmagicdesign.resolve-Panels.desktop
	newmenu share/blackmagicraw-player.desktop com.blackmagicdesign.rawplayer.desktop
	newmenu share/blackmagicraw-speedtest.desktop com.blackmagicdesign.rawspeedtest.desktop

	if [[ -f share/DaVinciRemoteMonitoring.desktop ]]; then
		newmenu share/DaVinciRemoteMonitoring.desktop com.blackmagicdesign.resolve-DaVinciRemoteMonitoring.desktop
	fi

	insinto /usr/share/desktop-directories
	newins share/DaVinciResolve.directory com.blackmagicdesign.resolve.directory

	insinto /etc/xdg/menus/applications-merged
	newins share/DaVinciResolve.menu com.blackmagicdesign.resolve.menu

	newicon graphics/DV_Resolve.png DaVinci-Resolve.png
	newicon graphics/DV_ResolveProj.png DaVinci-ResolveProj.png
	newicon graphics/DV_ServerAccess.png DaVinci-ResolveDbKey.png
	newicon -s 48 graphics/blackmagicraw-player_48x48_apps.png blackmagicraw-player.png
	newicon -s 48 graphics/blackmagicraw-speedtest_48x48_apps.png blackmagicraw-speedtest.png
	newicon -s 256 graphics/blackmagicraw-player_256x256_apps.png blackmagicraw-player.png
	newicon -s 256 graphics/blackmagicraw-speedtest_256x256_apps.png blackmagicraw-speedtest.png
	newicon -s 48 -c mimetypes graphics/application-x-braw-clip_48x48_mimetypes.png application-x-braw-clip.png
	newicon -s 48 -c mimetypes graphics/application-x-braw-sidecar_48x48_mimetypes.png application-x-braw-sidecar.png
	newicon -s 64 -c mimetypes graphics/DV_ResolveBin.png application-x-resolvebin.png
	newicon -s 64 -c mimetypes graphics/DV_ResolveProj.png application-x-resolveproj.png
	newicon -s 64 -c mimetypes graphics/DV_ResolveTimeline.png application-x-resolvetimeline.png
	newicon -s 64 -c mimetypes graphics/DV_ServerAccess.png application-x-resolvedbkey.png
	newicon -s 64 -c mimetypes graphics/DV_TemplateBundle.png application-x-resolvetemplatebundle.png
	newicon -s 256 -c mimetypes graphics/application-x-braw-clip_256x256_mimetypes.png application-x-braw-clip.png
	newicon -s 256 -c mimetypes graphics/application-x-braw-sidecar_256x256_mimetypes.png application-x-braw-sidecar.png

	keepdir "${PKG_HOME}"/{configs,logs,GPUCache,Media}

	keepdir /var/BlackmagicDesign/DaVinci\ Resolve
	chmod a+w "${ED}${PKG_HOME}/Apple Immersive" || die
	chmod 0777 "${ED}/var/BlackmagicDesign/DaVinci Resolve" || die

	make_wrapper \
		resolve \
		"${PKG_HOME}/bin/resolve" \
		"${PKG_HOME}" \
		"${PKG_HOME}/libs:${PKG_HOME}/bin" \
		/usr/bin

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
