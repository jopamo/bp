# Distributed under the terms of the GNU General Public License v2

# Current version
# https://dl.google.com/widevine-cdm/current.txt

EAPI=7

DESCRIPTION="a content decryption module (CDM) for the digital rights management (DRM) of the Google Chrome web browser."
HOMEPAGE="https://www.google.com/chrome"
SRC_URI="https://dl.google.com/widevine-cdm/${PV}-linux-x64.zip"

LICENSE="google-chrome"
SLOT=0/1
KEYWORDS="amd64"

RESTRICT="bindist mirror strip"

RDEPEND="
	lib-dev/glib:2
	lib-dev/nspr
	lib-dev/nss
"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	insinto /usr/lib/chromium
	doins libwidevinecdm.so
}
