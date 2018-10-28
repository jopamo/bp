# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools git-r3 multilib-minimal

DESCRIPTION="A system-independent library for user-level network packet capture"
EGIT_REPO_URI="https://github.com/the-tcpdump-group/libpcap"
HOMEPAGE="http://www.tcpdump.org/"

LICENSE="BSD"
SLOT="0"
IUSE="bluetooth dbus netlink static-libs usb"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	bluetooth? ( app-net/bluez:=[${MULTILIB_USEDEP}] )
	dbus? ( sys-app/dbus[${MULTILIB_USEDEP}] )
	netlink? ( lib-dev/libnl:3[${MULTILIB_USEDEP}] )
	usb? ( lib-dev/libusb[${MULTILIB_USEDEP}] )
"
DEPEND="
	${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	dbus? ( dev-util/pkgconfig[${MULTILIB_USEDEP}] )
"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" \
	econf \
		$(use_enable bluetooth) \
		$(use_enable dbus) \
		$(use_enable usb) \
		$(use_with netlink libnl)
}

multilib_src_compile() {
	emake all shared
}
