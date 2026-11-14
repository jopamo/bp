# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.info/ https://github.com/libusb/libusb"
SNAPSHOT=d3937ff1c8894d51cecd2bbb835db0e5cf42421f
SRC_URI="https://github.com/libusb/libusb/archive/${SNAPSHOT}.tar.gz -> libusb-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libusb-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs test udev"

PATCHES=( "${FILESDIR}/${PN}-stress-missing-device.patch" )

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug debug-log)
		$(use_enable static-libs static)
		$(use_enable test tests-build)
		$(use_enable udev)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake check
}

src_install() {
	default
	qa-policy-install
}
