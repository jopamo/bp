# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"

SNAPSHOT=3db1b647f059c9473269085739efa6716915151d
SRC_URI="https://github.com/gregkh/usbutils/archive/${SNAPSHOT}.tar.gz -> usbutils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/usbutils-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libusb
	app-compression/xz-utils
"
