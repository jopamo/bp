# Distributed under the terms of the GNU General Public License v2

inherit meson doins

DESCRIPTION="CCID free software driver"
HOMEPAGE="https://ccid.apdu.fr https://github.com/LudovicRousseau/CCID"
SNAPSHOT=662428ff3debc14fe9e7c3d5c0d5282d720ed5c7
SRC_URI="https://github.com/LudovicRousseau/ccid/archive/${SNAPSHOT}.tar.gz -> ccid-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/CCID-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="twinserial"

RDEPEND="
	app-crypto/pcsc-lite
	lib-dev/libusb
"
DEPEND="${RDEPEND}
	lib-core/zlib
"
BDEPEND="
	app-build/flex
	app-dev/pkgconf
	app-lang/perl
"

src_prepare() {
	filter-flags -Wl,-z,defs

	default
}

src_configure() {
	local emesonargs=(
		$(meson_use twinserial serial)
		-Dudev-rules=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	udev_newrules src/92_pcscd_ccid.rules 92-pcsc-ccid.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
