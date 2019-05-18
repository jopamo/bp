# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"
SRC_URI="mirror://kernel/linux/utils/usb/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/libusb
	sys-app/systemd
	app-compression/xz-utils
	dev-util/pkgconf
	sys-app/systemd"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--datarootdir="${EPREFIX}/usr/share" \
		--datadir="${EPREFIX}/usr/share/misc"
}
