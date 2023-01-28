# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://www.bluez.org"
SRC_URI="https://www.kernel.org/pub/linux/bluetooth/${P}.tar.xz"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="btpclient cups debug extra-tools +experimental +mesh +readline selinux systemd +udev user-session"

BDEPEND="app-dev/pkgconf"
DEPEND="
	lib-live/glib
	btpclient? ( lib-dev/ell )
	cups? ( lib-print/cups )
	mesh? (
		lib-dev/ell
		lib-live/json-c
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
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-bluetooth )
"

RESTRICT="test"

filter-flags -Wl,-z,defs

pkg_setup() {
	# From http://www.linuxfromscratch.org/blfs/view/svn/general/bluez.html
	# to prevent bugs like:
	# https://bugzilla.kernel.org/show_bug.cgi?id=196621
	CONFIG_CHECK="~NET ~BT ~BT_RFCOMM ~BT_RFCOMM_TTY ~BT_BNEP ~BT_BNEP_MC_FILTER
				~BT_BNEP_PROTO_FILTER ~BT_HIDP ~RFKILL"
	# https://bugzilla.kernel.org/show_bug.cgi?id=196621
	# https://bugzilla.kernel.org/show_bug.cgi?id=206815
	if use mesh ; then
		CONFIG_CHECK="${CONFIG_CHECK} ~CRYPTO_USER
		~CRYPTO_USER_API ~CRYPTO_USER_API_AEAD ~CRYPTO_USER_API_HASH
		~CRYPTO_AES ~CRYPTO_CCM ~CRYPTO_AEAD ~CRYPTO_CMAC"
	fi

	linux-info_pkg_setup
}

src_configure() {
	local myconf=(
		$(use_enable btpclient external-ell)
		$(use_enable btpclient)
		$(use_enable cups)
		$(use_enable debug)
		$(use_enable experimental)
		$(use_enable mesh external-ell)
		$(use_enable mesh)
		$(use_enable readline client)
		$(use_enable systemd)
		$(use_enable udev sixaxis)
		$(use_enable udev)
		--enable-android
		--enable-deprecated
		--disable-midi
		--disable-obex
		--enable-datafiles
		--enable-library
		--enable-manpages
		--enable-monitor
		--enable-optimization
		--enable-pie
		--enable-threads
		--enable-tools
		--localstatedir=/var
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--with-systemduserunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/user" "false")
		ac_cv_header_readline_readline_h=$(usex mesh)
		ac_cv_header_readline_readline_h=$(usex readline)
		ax_cv_c_float_words_bigendian=no
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
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
