# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils toolchain-funcs multilib-minimal

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.info/ https://github.com/libusb/libusb"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="amd64 arm64"
IUSE="debug doc examples static-libs test udev"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )
	!udev? ( sys-kernel/stable-sources )"

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		$(use_enable static-libs static) \
		$(use_enable udev) \
		$(use_enable debug debug-log) \
		$(use_enable test tests-build)
}

multilib_src_compile() {
	emake

	if multilib_is_native_abi; then
		use doc && emake -C doc docs
	fi
}

multilib_src_test() {
	emake check

	# noinst_PROGRAMS from tests/Makefile.am
	tests/stress || die
}
