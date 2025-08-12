# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="libpcap-$(ver_cut 1-2)"

inherit autotools

DESCRIPTION="A system-independent library for user-level network packet capture"
HOMEPAGE="http://www.tcpdump.org/"
SNAPSHOT=53e4a8b4c0c90e096d97dd1c3b47b38a1248f838
SRC_URI="https://github.com/the-tcpdump-group/libpcap/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libpcap-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bluetooth dbus netlink static-libs usb"

RDEPEND="
	bluetooth? ( app-net/bluez:= )
	dbus? ( app-core/dbus )
	netlink? ( lib-net/libnl )
	usb? ( lib-dev/libusb )
"
DEPEND="
	${RDEPEND}
	app-build/flex
	app-build/bison
	dbus? ( app-dev/pkgconf )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable bluetooth)
		$(use_enable dbus)
		$(use_enable usb)
		$(use_with netlink libnl)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	emake all shared
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
