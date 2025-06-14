# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools doins flag-o-matic

DESCRIPTION="CCID free software driver"
HOMEPAGE="https://ccid.apdu.fr https://github.com/LudovicRousseau/CCID"

SNAPSHOT=22eefddb910320894b8501917d4ac497ca08b285
SRC_URI="https://github.com/LudovicRousseau/ccid/archive/${SNAPSHOT}.tar.gz -> ccid-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/CCID-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="twinserial +usb"

RDEPEND="
	app-crypto/pcsc-lite
	twinserial? ( app-lang/perl )
	usb? ( lib-dev/libusb )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	filter-flags -Wl,-z,defs

	default
	eautoreconf
}

src_configure() {
	econf \
		LEX=: \
		$(use_enable twinserial) \
		$(use_enable usb libusb)
}

src_install() {
	default
	udev_newrules src/92_pcscd_ccid.rules 92-pcsc-ccid.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
