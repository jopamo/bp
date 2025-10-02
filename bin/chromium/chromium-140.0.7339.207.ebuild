# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Google Chromium, sans integration with Google"
HOMEPAGE="https://github.com/ungoogled-software/ungoogled-chromium-portablelinux"

BASE_URI="https://github.com/ungoogled-software/ungoogled-chromium-portablelinux/releases/download"

# prefer folder ${PV}-2 and fall back to ${PV}-1 for each arch
# keep upstream filename with -1 in name, just rename locally for clarity
SRC_URI="
	amd64? (
		${BASE_URI}/${PV}-2/ungoogled-chromium-${PV}-1-x86_64_linux.tar.xz -> ${PN}-${PV}-x86_64.tar.xz
		${BASE_URI}/${PV}-1/ungoogled-chromium-${PV}-1-x86_64_linux.tar.xz -> ${PN}-${PV}-x86_64.tar.xz
	)
	arm64? (
		${BASE_URI}/${PV}-2/ungoogled-chromium-${PV}-1-arm64_linux.tar.xz -> ${PN}-${PV}-arm64.tar.xz
		${BASE_URI}/${PV}-1/ungoogled-chromium-${PV}-1-arm64_linux.tar.xz -> ${PN}-${PV}-arm64.tar.xz
	)
"

# archive extracts into ungoogled-chromium_${PV}-1_linux so probe in src_install
S="${WORKDIR}"

RESTRICT="strip mirror"

LICENSE="CHROME"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-compression/bzip2
	app-core/dbus
	fonts/fontconfig
	lib-core/expat
	lib-core/libcap
	lib-dev/nspr
	lib-dev/nss
	lib-util/glib
	lib-print/cups
	xgui-icontheme/adwaita-icon-theme
	xgui-lib/at-spi2-core
	xgui-lib/cairo
	xgui-lib/gdk-pixbuf
	xgui-lib/gtk3
	xgui-lib/libxcb
	xgui-lib/libxkbcommon
	xgui-lib/pango
	xgui-tools/alsa-lib
	xgui-lib/freetype
"

QA_PREBUILT="*"

src_install() {
	local srcdir=
	for srcdir in "${WORKDIR}"/ungoogled-chromium_${PV}-*_linux; do
		[[ -d ${srcdir} ]] && break
	done
	[[ -d ${srcdir} ]] || die "failed to find extracted dir for ${PV}"

	mkdir -p "${ED}"/opt/chromium
	cp -rp "${srcdir}"/* "${ED}"/opt/chromium/

	dodir /usr/bin
	cat > "${T}"/chromium <<-'EOF' || die
	#!/bin/sh
	exec /opt/chromium/chrome "$@"
	EOF
	dobin "${T}"/chromium

	fperms 0755 /opt/chromium/chrome
	fperms 0755 /opt/chromium/chrome_crashpad_handler
	fperms 4755 /opt/chromium/chrome_sandbox

	insopts -m 0644
	insinto /usr/share/pixmaps
	[[ -f ${FILESDIR}/chromium.png ]] && doins "${FILESDIR}"/chromium.png
}
