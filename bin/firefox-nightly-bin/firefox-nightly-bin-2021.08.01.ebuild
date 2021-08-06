# Distributed under the terms of the GNU General Public License v2

EAPI=7

MOZ_PN="firefox-nightly"
TIMESTAMP="09-46-07"
MOZ_VER="92.0a1"

inherit xdg-utils

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.com/firefox"
SRC_URI="https://archive.mozilla.org/pub/firefox/nightly/$(ver_cut 1)/$(ver_cut 2)/$(ver_cut 1)-$(ver_cut 2)-$(ver_cut 3)-${TIMESTAMP}-mozilla-central/firefox-${MOZ_VER}.en-US.linux-x86_64.tar.bz2 -> firefox-${PV}.tar.bz2"
S="${WORKDIR}/firefox"

RESTRICT="strip mirror"

LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="lib-gui/atk
	>=sys-app/dbus-0.60
	>=lib-dev/dbus-glib-0.72
	>=lib-dev/glib-2.26:2
	lib-media/fontconfig
	>=lib-media/freetype-2.4.10
	>=lib-gui/cairo-1.10[X]
	x11-live-libs/gdk-pixbuf
	lib-dev/nss
	>=x11-live-libs/gtk+-3.4.0:3
	app-text/hunspell
	x11-live-libs/libX11
	x11-live-libs/libXcomposite
	x11-live-libs/libXdamage
	x11-live-libs/libXext
	x11-live-libs/libXfixes
	x11-live-libs/libXrender
	x11-live-libs/libXt
	>=x11-live-libs/pango-1.22.0
	app-media/pulseaudio
	app-media/ffmpeg
"

QA_PREBUILT="*"

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
	mkdir -p "${ED}"/opt/${MOZ_PN}/
	cp -rp "${S}"/* "${ED}"/opt/${MOZ_PN}/

	# Disable built-in auto-update because we update firefox-bin through package manager
	insinto opt/${MOZ_PN}/distribution/
	newins "${FILESDIR}"/disable-auto-update.policy.json policies.json

	# Fix prefs that make no sense for a system-wide install
	insinto opt/${MOZ_PN}/defaults/pref/
	doins "${FILESDIR}"/local-settings.js
	insinto opt/${MOZ_PN}
	doins "${FILESDIR}"/all-set.js

	# Create /usr/bin/firefox-bin
	dodir /usr/bin/
	cat <<-EOF >"${D}"/usr/bin/${PN}
	#!/bin/sh
	exec /opt/${MOZ_PN}/firefox-bin "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}
	fperms 0755 /opt/${MOZ_PN}/firefox
	fperms 0755 /opt/${MOZ_PN}/firefox-bin

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=opt/${MOZ_PN}" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die

	rm -f "${ED}"/opt/${MOZ_PN}/pingsender
	rm -f "${ED}"/opt/${MOZ_PN}/minidump-analyzer
	rm -f "${ED}"/opt/${MOZ_PN}/crashreporter*
	rm -f "${ED}"/opt/${MOZ_PN}/libnssckbi.so
	rm -rf "${ED}"/opt/${MOZ_PN}/dictionaries

	dosym /usr/share/hunspell opt/${MOZ_PN}/dictionaries
	dosym /usr/lib/libnssckbi.so opt/${MOZ_PN}/libnssckbi.so
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
