# Distributed under the terms of the GNU General Public License v2

EAPI=8

MOZ_PN="firefox-nightly"
TIMESTAMP="09-20-38"
MOZ_VER="104.0a1"

inherit xdg-utils

DESCRIPTION="Firefox Web Browser"
HOMEPAGE="http://www.mozilla.com/firefox"
SRC_URI="https://archive.mozilla.org/pub/firefox/nightly/$(ver_cut 1)/$(ver_cut 2)/$(ver_cut 1)-$(ver_cut 2)-$(ver_cut 3)-${TIMESTAMP}-mozilla-central/firefox-${MOZ_VER}.en-US.linux-x86_64.tar.bz2 -> firefox-${PV}.tar.bz2"
S="${WORKDIR}/firefox"

RESTRICT="strip mirror"

LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	app-core/dbus
	app-tex/hunspell
	fonts/fontconfig
	lib-dev/dbus-glib
	lib-dev/nss
	lib-live/glib
	xgui-live-lib/at-spi2-core
	xgui-live-lib/cairo[X]
	xgui-live-lib/gdk-pixbuf
	xgui-live-lib/gtk+:3
	xgui-live-lib/pango
	xgui-misc/freetype
	xgui-misc/pulseaudio
	xmedia-live-app/ffmpeg
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

	fperms 0755 /opt/${MOZ_PN}/firefox
	fperms 0755 /opt/${MOZ_PN}/firefox-bin

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=opt/${MOZ_PN}" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die

	rm "${ED}"/opt/${MOZ_PN}/pingsender || die
	rm "${ED}"/opt/${MOZ_PN}/minidump-analyzer || die
	rm "${ED}"/opt/${MOZ_PN}/crashreporter* || die
	rm "${ED}"/opt/${MOZ_PN}/libnssckbi.so || die

	dosym -r /usr/share/hunspell /opt/${MOZ_PN}/dictionaries
	dosym -r /usr/lib/libnssckbi.so /opt/${MOZ_PN}/libnssckbi.so

	dodir /usr/bin/
	dosym -r /usr/bin/firefox-nightly-bin /usr/bin/firefox

	# Create /usr/bin/firefox-bin
	cat <<-EOF >"${D}"/usr/bin/${PN}
	#!/bin/sh
	exec /opt/${MOZ_PN}/firefox-bin "\$@"
	EOF

	fperms 0755 /usr/bin/${PN}
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
