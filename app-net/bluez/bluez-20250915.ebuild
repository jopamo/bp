# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info autotools

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://www.bluez.org"
SNAPSHOT=4d7d25b702454a7c5e4b88877d463860b10dbd69
SRC_URI="https://github.com/bluez/bluez/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="extra-tools mesh readline selinux systemd test test-programs
	+udev user-session"

BDEPEND="app-dev/pkgconf"
DEPEND="
	lib-dev/ell
	lib-util/glib
	mesh? (
		lib-dev/json-c
		lib-core/readline
	)
	readline? ( lib-core/readline )
	systemd? (
		app-core/dbus[user-session=]
		app-core/systemd
	)
	!systemd? ( app-core/dbus )
	udev? ( app-core/systemd )
"
RDEPEND="${DEPEND}"

RESTRICT="test"

pkg_setup() {
	# From http://www.linuxfromscratch.org/blfs/view/svn/general/bluez.html
	# to prevent bugs like:
	# https://bugzilla.kernel.org/show_bug.cgi?id=196621
	CONFIG_CHECK="~NET ~BT ~BT_RFCOMM ~BT_RFCOMM_TTY ~BT_BNEP ~BT_BNEP_MC_FILTER
		~BT_BNEP_PROTO_FILTER ~BT_HIDP ~CRYPTO_USER_API_HASH ~CRYPTO_USER_API_SKCIPHER
		~UHID ~RFKILL"
	# https://bugzilla.kernel.org/show_bug.cgi?id=196621
	# https://bugzilla.kernel.org/show_bug.cgi?id=206815
	if use mesh || use test; then
		CONFIG_CHECK="${CONFIG_CHECK} ~CRYPTO_USER
		~CRYPTO_USER_API ~CRYPTO_USER_API_AEAD ~CRYPTO_AES ~CRYPTO_CCM ~CRYPTO_AEAD ~CRYPTO_CMAC
		~CRYPTO_MD5 ~CRYPTO_SHA1 ~KEY_DH_OPERATIONS"
	fi
	linux-info_pkg_setup

	if use test || use test-programs; then
		python-single-r1_pkg_setup
	fi

	if ! use udev; then
		ewarn
		ewarn "You are installing ${PN} with USE=-udev. This means various bluetooth"
		ewarn "devices and adapters from Apple, Dell, Logitech etc. will not work,"
		ewarn "and hid2hci will not be available."
		ewarn
	fi
}

src_prepare() {
	default
	eautoreconf
	use elibc_musl && eapply "${FILESDIR}/gdbus-define-MAX_INPUT-for-musl.patch"
}

src_configure() {
	filter-flags -Wl,-z,defs

	local myconf=(
		$(use_enable systemd)
		--disable-obex
		--enable-btpclient
		--enable-datafiles
		--enable-deprecated
		--enable-experimental
		--enable-external-ell
		--enable-hid2hci
		--enable-manpages
		--enable-mesh
		--enable-midi
		--enable-android
		--enable-sixaxis
		--enable-udev
		--enable-external-ell
		--enable-library
		--enable-client
		--localstatedir="${EPREFIX}"/var
		--libexecdir="${EPREFIX}"/usr/lib
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--with-systemduserunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/user" "false")
	)

	econf "${myconf[@]}"
}

src_install() {
	default

	keepdir /var/lib/bluetooth

	# Setup auto enable as Fedora does for allowing to use
	# keyboards/mouse as soon as possible
	sed -i 's/#\[Policy\]$/\[Policy\]/; s/#AutoEnable=false/AutoEnable=true/' src/main.conf || die
	doins src/main.conf
}

pkg_postinst() {
	use systemd && systemctl reenable bluetooth.service
}
