# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.info/ https://github.com/libusb/libusb"

SNAPSHOT=ed09a92b0b39fa906bf964a50a8b8a8c27c09877
SRC_URI="https://github.com/libusb/libusb/archive/${SNAPSHOT}.tar.gz -> libusb-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libusb-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs test udev"

src_prepare() {
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

	# noinst_PROGRAMS from tests/Makefile.am
	tests/stress || die
}
