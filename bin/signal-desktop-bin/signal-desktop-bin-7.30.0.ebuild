# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit unpacker xdg

DESCRIPTION="Allows you to send and receive messages of Signal Messenger on your computer"
HOMEPAGE="https://signal.org/"
SRC_URI="https://updates.signal.org/desktop/apt/pool/s/${MY_PN}/${MY_PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3 MIT MIT-with-advertising BSD-1 BSD-2 BSD Apache-2.0 ISC openssl ZLIB APSL-2 icu Artistic-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-* amd64"

RESTRICT="splitdebug"

QA_PREBUILT="
	opt/Signal/chrome_crashpad_handler
	opt/Signal/chrome-sandbox
	opt/Signal/libEGL.so
	opt/Signal/libGLESv2.so
	opt/Signal/libffmpeg.so
	opt/Signal/libvk_swiftshader.so
	opt/Signal/libvulkan.so.1
	opt/Signal/resources/app.asar.unpacked/node_modules/*
	opt/Signal/signal-desktop
	opt/Signal/swiftshader/libEGL.so
	opt/Signal/swiftshader/libGLESv2.so"

src_prepare() {
	default
	sed -e 's| --no-sandbox||g' \
		-i usr/share/applications/signal-desktop.desktop || die
	unpack usr/share/doc/signal-desktop/changelog.gz
}

src_install() {
	insinto /
	dodoc changelog
	doins -r opt
	insinto /usr/share

	doins -r usr/share/applications
	doins -r usr/share/icons
	fperms +x /opt/Signal/signal-desktop /opt/Signal/chrome-sandbox /opt/Signal/chrome_crashpad_handler
	fperms u+s /opt/Signal/chrome-sandbox

	dosym -r /opt/Signal/${MY_PN} /usr/bin/${MY_PN}
}
