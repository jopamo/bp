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

# archive extracts into ungoogled-chromium-${PV}-<rev>-<arch>_linux so probe in src_install
S="${WORKDIR}"

LICENSE="CHROME"

RESTRICT="strip mirror"
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
	# map Gentoo ARCH to upstream dir suffix used in the tarball
	local platform
	case ${ARCH} in
		amd64) platform=x86_64_linux ;;
		arm64) platform=arm64_linux ;;
		*)     platform=${ARCH}_linux ;;
	esac

	# upstream dir looks like ungoogled-chromium-${PV}-<rev>-${platform}
	# be tolerant of minor naming tweaks by trying both dash and underscore after project name
	local srcdir=
	for srcdir in \
		"${WORKDIR}/ungoogled-chromium-${PV}-"*"-${platform}" \
		"${WORKDIR}/ungoogled-chromium_${PV}-"*"-${platform}"
	do
		[[ -d ${srcdir} ]] && break
	done
	[[ -d ${srcdir} ]] || die "failed to find extracted dir for ${PV} under ${WORKDIR}"

	# install under /opt to keep tree intact like upstream expects
	dodir /opt/chromium
	cp -rp "${srcdir}/"* "${ED}/opt/chromium/" || die

	# wrapper for stable CLI path
	dodir /usr/bin
	cat > "${T}/chromium" <<-'EOF' || die
	#!/bin/sh
	exec /opt/chromium/chrome "$@"
	EOF
	dobin "${T}/chromium"

	# permissions expected by chromium sandbox
	fperms 0755 /opt/chromium/chrome
	fperms 0755 /opt/chromium/chrome_crashpad_handler

	# optional icon if provided in FILESDIR
	insopts -m 0644
	insinto /usr/share/pixmaps
	[[ -f ${FILESDIR}/chromium.png ]] && doins "${FILESDIR}/chromium.png"
}
