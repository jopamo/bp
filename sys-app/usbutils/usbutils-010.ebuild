# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usbutils.git/"
SRC_URI="mirror://kernel/linux/utils/usb/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

CDEPEND="lib-dev/libusb
	sys-app/systemd:="
DEPEND="${CDEPEND}
	app-compression/xz-utils
	dev-util/pkgconf"
RDEPEND="${CDEPEND}
	sys-app/systemd
"

src_configure() {
	econf \
		--datarootdir="${EPREFIX}/usr/share" \
		--datadir="${EPREFIX}/usr/share/misc"
}

src_install() {
	default
	newdoc usbhid-dump/NEWS NEWS.usbhid-dump
}
