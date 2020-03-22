# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=c92f1962892d709cb9bad3aac2440932dd9684f6

inherit autotools

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"
SRC_URI="https://github.com/gregkh/usbutils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/libusb
	virtual/service-manager
	app-compression/xz-utils
	dev-util/pkgconf
"

src_prepare() {
	default
	eautoreconf
}
