# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"
SNAPSHOT=06df383d9deb6a3ccc3fb9eb1f271770409b777b
SRC_URI="https://github.com/gregkh/usbutils/archive/${SNAPSHOT}.tar.gz -> usbutils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/usbutils-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libusb
	app-compression/xz-utils
"
