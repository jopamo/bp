# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.info/ https://github.com/libusb/libusb"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="debug doc examples static-libs test udev"

DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )
	!udev? ( sys-app/copperhead-sources )"

src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		$(use_enable static-libs static) \
		$(use_enable udev) \
		$(use_enable debug debug-log) \
		$(use_enable test tests-build)
}

src_test() {
	emake check

	# noinst_PROGRAMS from tests/Makefile.am
	tests/stress || die
}
