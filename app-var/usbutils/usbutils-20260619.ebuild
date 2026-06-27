# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"
SNAPSHOT=c1a020adc8ffd7f2dc46b4e46ffc47a0108e58d8
SRC_URI="https://github.com/gregkh/usbutils/archive/${SNAPSHOT}.tar.gz -> usbutils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/usbutils-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libusb
	app-compression/xz-utils
"
