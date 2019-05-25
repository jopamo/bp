# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="A system-independent library for user-level network packet capture"
SRC_URI="https://www.tcpdump.org/release/${P}.tar.gz"
HOMEPAGE="http://www.tcpdump.org/"

LICENSE="BSD"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="bluetooth dbus netlink static-libs usb"

RDEPEND="
	bluetooth? ( app-net/bluez:= )
	dbus? ( sys-app/dbus )
	netlink? ( lib-dev/libnl:3 )
	usb? ( lib-dev/libusb )
"
DEPEND="
	${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	dbus? ( dev-util/pkgconf )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" \
	econf \
		$(use_enable bluetooth) \
		$(use_enable dbus) \
		$(use_enable usb) \
		$(use_with netlink libnl)
}

src_compile() {
	emake all shared
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
