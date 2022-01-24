# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/usb/usbutils/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/gregkh/usbutils"
	inherit git-r3
	EGIT_SUBMODULES=()
else
	SNAPSHOT=bf595a0cb0eb132b7365e8f1d19f07b255cbf191
	SRC_URI="https://github.com/gregkh/usbutils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libusb
	app-compression/xz-utils
"

src_prepare() {
	default
	eautoreconf
}
