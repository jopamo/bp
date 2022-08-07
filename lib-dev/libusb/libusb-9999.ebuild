# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.info/ https://github.com/libusb/libusb"
EGIT_REPO_URI="https://github.com/libusb/libusb.git"

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
