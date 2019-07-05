# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="google-chrome-unstable"
MY_PV=${PV}-1
MY_P="${MY_PN}_${MY_PV}"

inherit unpacker

DESCRIPTION="Binary plugins from Google Chrome for use in Chromium"
HOMEPAGE="https://www.google.com/chrome"
SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_amd64.deb"

LICENSE="google-chrome"
SLOT=0/1
KEYWORDS="amd64"

RESTRICT="bindist mirror strip"

RDEPEND="
	lib-dev/glib:2
	lib-dev/nspr
	lib-dev/nss
"

S="${WORKDIR}/opt/google/chrome-unstable"

QA_PREBUILT="*"

src_install() {
	insinto /usr/lib/chromium
	doins libwidevinecdm.so
	dosym ../chromium/libwidevinecdm.so usr/lib/chromium-browser/libwidevinecdm.so
}
