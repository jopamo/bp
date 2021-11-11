# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="A system-independent library for user-level network packet capture"
HOMEPAGE="http://www.tcpdump.org/"
EGIT_REPO_URI="https://github.com/the-tcpdump-group/libpcap.git"
EGIT_BRANCH="libpcap-$(ver_cut 1).$(ver_cut 2)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bluetooth dbus netlink static-libs usb"

RDEPEND="
	bluetooth? ( app-net/bluez:= )
	dbus? ( app-core/dbus )
	netlink? ( lib-dev/libnl:3 )
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
