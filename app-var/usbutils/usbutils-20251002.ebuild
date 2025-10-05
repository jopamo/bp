# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"
SNAPSHOT=366f12c77d658c86e04a0401a3c7075d5be1505d
SRC_URI="https://github.com/gregkh/usbutils/archive/${SNAPSHOT}.tar.gz -> usbutils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/usbutils-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libusb
	app-compression/xz-utils
"
