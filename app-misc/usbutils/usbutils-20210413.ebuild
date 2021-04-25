# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=e7dcdafb1edb4721f59562c259b102b2f81ae423

inherit autotools

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"
SRC_URI="https://github.com/gregkh/usbutils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/libusb
	app-compression/xz-utils"

src_prepare() {
	default
	eautoreconf
}
