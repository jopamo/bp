# Distributed under the terms of the GNU General Public License v2

EAPI=6
QT5_MODULE="qtbase"
inherit qt5-build

DESCRIPTION="Network abstraction library for the Qt5 framework"
KEYWORDS="amd64 arm64 x86"

IUSE="bindist connman libproxy networkmanager +ssl"

DEPEND="
	~gui-lib/qtcore-${PV}
	>=lib-sys/zlib-1.2.5
	connman? ( ~gui-lib/qtdbus-${PV} )
	libproxy? ( lib-net/libproxy )
	networkmanager? ( ~gui-lib/qtdbus-${PV} )
	ssl? ( lib-dev/openssl:0=[bindist=] )
"
RDEPEND="${DEPEND}
	connman? ( app-net/connman )
	networkmanager? ( app-net/networkmanager )
"

QT5_TARGET_SUBDIRS=(
	src/network
	src/plugins/bearer/generic
)

QT5_GENTOO_CONFIG=(
	libproxy
	ssl::SSL
	ssl::OPENSSL
	ssl:openssl-linked:LINKED_OPENSSL
)

QT5_GENTOO_PRIVATE_CONFIG=(
	:network
)

pkg_setup() {
	use connman && QT5_TARGET_SUBDIRS+=(src/plugins/bearer/connman)
	use networkmanager && QT5_TARGET_SUBDIRS+=(src/plugins/bearer/networkmanager)
}

src_configure() {
	local myconf=(
		$(use connman || use networkmanager && echo -dbus-linked)
		$(qt_use libproxy)
		$(usex ssl -openssl-linked '')
	)
	qt5-build_src_configure
}
