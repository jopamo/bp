# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=bc48602be0329c312ac5fd415c17b7f1b6dd3189

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
