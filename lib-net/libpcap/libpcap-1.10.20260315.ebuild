# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="libpcap-$(ver_cut 1-2)"

inherit autotools qa-policy

DESCRIPTION="A system-independent library for user-level network packet capture"
HOMEPAGE="http://www.tcpdump.org/"
SNAPSHOT=1424800fdbbd2380818e19c902a09cdb77512fda
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
	PATCHES=(
		"${FILESDIR}/${PN}-1.10.20260228-static-stoulen.patch"
	)
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure
	local myconf=(
		$(use_enable bluetooth)
		$(use_enable dbus)
		$(use_enable usb)
		$(use_with netlink libnl)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	qa-policy-compile
	emake all shared
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
