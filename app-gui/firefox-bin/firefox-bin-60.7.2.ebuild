# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOZ_PN="${PN/-bin}"
MOZ_PV="${PV}"

MOZ_P="${MOZ_PN}-${MOZ_PV}"

MOZ_HTTP_URI="https://archive.mozilla.org/pub/mozilla.org/${MOZ_PN}/releases/"

inherit xdg-utils

DESCRIPTION="Firefox Web Browser"
SRC_URI="${SRC_URI}
	amd64? ( ${MOZ_HTTP_URI%/}/${MOZ_PV}/linux-x86_64/en-US/${MOZ_P}.tar.bz2 -> ${PN}_x86_64-${PV}.tar.bz2 )"
HOMEPAGE="http://www.mozilla.com/firefox"
RESTRICT="strip mirror"

LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0/1"
KEYWORDS="amd64"

IUSE="+ffmpeg +pulseaudio"

RDEPEND="gui-lib/atk
	>=sys-app/dbus-0.60
	>=lib-dev/dbus-glib-0.72
	>=lib-dev/glib-2.26:2
	lib-media/fontconfig
	>=lib-media/freetype-2.4.10
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf
	lib-dev/nss
	>=x11-libs/gtk+-3.4.0:3
	app-text/hunspell
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	>=x11-libs/pango-1.22.0
	pulseaudio? ( !<app-media/apulse-0.1.9
		|| ( app-media/pulseaudio app-media/apulse ) )
	ffmpeg? ( app-media/ffmpeg )
"

QA_PREBUILT="
	opt/${MOZ_PN}/*.so
	opt/${MOZ_PN}/${MOZ_PN}
	opt/${MOZ_PN}/${PN}
	opt/${MOZ_PN}/crashreporter
	opt/${MOZ_PN}/webapprt-stub
	opt/${MOZ_PN}/plugin-container
	opt/${MOZ_PN}/mozilla-xremote-client
	opt/${MOZ_PN}/updater
"

S="${WORKDIR}/${MOZ_PN}"

src_unpack() {
	unpack ${A}
}

src_install() {
	local size sizes icon_path icon name
	sizes="16 32 48 128"
	icon_path="${S}/browser/chrome/icons/default"
	icon="${PN}"
	name="Mozilla Firefox"

	# Install icons and .desktop for menu entry
	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png" || die
	done
	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs
	newicon "${S}"/browser/chrome/icons/default/default48.png ${PN}.png

	# Install firefox in /opt
	dodir /opt/${MOZ_PN}/
	mv "${S}" "${ED}"/opt/ || die

	# Disable built-in auto-update because we update firefox-bin through package manager
	insinto opt/firefox/distribution/
	newins "${FILESDIR}"/disable-auto-update.policy.json policies.json

	# Fix prefs that make no sense for a system-wide install
	insinto opt/firefox/defaults/pref/
	doins "${FILESDIR}"/local-settings.js
	insinto opt/firefox
	doins "${FILESDIR}"/all-set.js

	# Create /usr/bin/firefox-bin
	dodir /usr/bin/
	cat <<-EOF >"${ED}"/usr/bin/${PN}
	#!/bin/sh
	exec /opt/${MOZ_PN}/${MOZ_PN} "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=opt/firefox" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die

	rm -f "${ED}"/opt/firefox/pingsender
	rm -f "${ED}"/opt/firefox/minidump-analyzer
	rm -f "${ED}"/opt/firefox/crashreporter*
	rm -f "${ED}"/opt/firefox/libnssckbi.so
	rm -rf "${ED}"/opt/firefox/dictionaries

	dosym /usr/share/hunspell opt/firefox/dictionaries
	dosym /usr/lib/libnssckbi.so opt/firefox/libnssckbi.so
}
