# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Brave Browser: Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com"
SRC_URI="amd64? ( https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser-nightly_${PV}_amd64.deb )"

RESTRICT="strip mirror"

LICENSE="https://raw.githubusercontent.com/brave/brave-browser/master/LICENSE"
SLOT="0/1"
KEYWORDS="amd64"

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	rm -rf etc usr/share/menu usr/share/doc usr/share/man || die
}
