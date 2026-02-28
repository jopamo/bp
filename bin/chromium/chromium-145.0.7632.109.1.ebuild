# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Google Chromium, sans integration with Google"
HOMEPAGE="https://github.com/ungoogled-software/ungoogled-chromium-portablelinux"

BASE_URI="https://github.com/ungoogled-software/ungoogled-chromium-portablelinux/releases/download"

MY_UP_PV=${PV%.*}
MY_REL=${PV##*.}

SRC_URI="
	amd64? (
		${BASE_URI}/${MY_UP_PV}-${MY_REL}/ungoogled-chromium-${MY_UP_PV}-1-x86_64_linux.tar.xz -> ${PN}-${MY_UP_PV}-x86_64.tar.xz
	)
	arm64? (
		${BASE_URI}/${MY_UP_PV}-${MY_REL}/ungoogled-chromium-${MY_UP_PV}-1-arm64_linux.tar.xz -> ${PN}-${MY_UP_PV}-arm64.tar.xz
	)
"

S="${WORKDIR}"

LICENSE="CHROME"

SLOT="0"
RESTRICT="strip mirror"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-compression/bzip2
	app-core/dbus
	fonts/fontconfig
	lib-core/expat
	lib-core/libcap
	lib-dev/nspr
	lib-dev/nss
	lib-core/glib
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
	local platform
	case ${ARCH} in
		amd64) platform=x86_64_linux ;;
		arm64) platform=arm64_linux ;;
		*) die "Unsupported ARCH=${ARCH}" ;;
	esac

	local srcdir=
	for srcdir in \
		"${WORKDIR}/ungoogled-chromium-${MY_UP_PV}-"*"-${platform}" \
		"${WORKDIR}/ungoogled-chromium_${MY_UP_PV}-"*"-${platform}"
	do
		[[ -d ${srcdir} ]] && break
	done
	[[ -d ${srcdir} ]] || die "failed to find extracted dir for ${MY_UP_PV} under ${WORKDIR}"

	dodir /opt/chromium
	cp -rp "${srcdir}/"* "${ED}/opt/chromium/" || die

	cat > "${T}/chromium" <<-'EOF' || die
	#!/bin/sh
	exec /opt/chromium/chrome "$@"
	EOF

	dobin "${T}/chromium"
	fperms 0755 /opt/chromium/chrome
	fperms 0755 /opt/chromium/chrome_crashpad_handler

	insopts -m 0644
	insinto /usr/share/pixmaps
	[[ -f ${FILESDIR}/chromium.png ]] && doins "${FILESDIR}/chromium.png"
}
