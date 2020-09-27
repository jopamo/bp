# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic linux-info systemd

DESCRIPTION="Bluetooth Tools and System Daemons for Linux"
HOMEPAGE="http://www.bluez.org"
SRC_URI="https://www.kernel.org/pub/linux/bluetooth/${P}.tar.xz"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/3"
KEYWORDS="amd64 arm64"

IUSE="btpclient cups doc debug extra-tools experimental +mesh +obex +readline selinux systemd +udev user-session"

BDEPEND="
	dev-util/pkgconf
"
DEPEND="
	>=lib-dev/glib-2.28:2
	btpclient? ( >=lib-dev/ell-0.28 )
	cups? ( lib-print/cups:= )
	mesh? (
		>=lib-dev/ell-0.28
		>=lib-dev/json-c-0.13:=
		lib-sys/readline:0=
	)
	obex? ( lib-dev/libical:= )
	readline? ( lib-sys/readline:0= )
	systemd? (
		>=sys-app/dbus-1.6:=[user-session=]
		sys-app/systemd
	)
	!systemd? ( >=sys-app/dbus-1.6:= )
	udev? ( sys-app/systemd )
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

	if ! use udev; then
		ewarn
		ewarn "You are installing ${PN} with USE=-udev. This means various bluetooth"
		ewarn "devices and adapters from Apple, Dell, Logitech etc. will not work,"
		ewarn "and hid2hci will not be available."
		ewarn
	fi
}

src_configure() {
	econf \
		ac_cv_header_readline_readline_h=$(usex readline) \
		ac_cv_header_readline_readline_h=$(usex mesh) \
		ax_cv_c_float_words_bigendian=no \
		--localstatedir=/var \
		--disable-android \
		--enable-datafiles \
		--enable-optimization \
		$(use_enable debug) \
		--enable-pie \
		--enable-threads \
		--enable-library \
		--enable-tools \
		--enable-manpages \
		--enable-monitor \
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)" \
		--with-systemduserunitdir="$(systemd_get_userunitdir)" \
		$(use_enable btpclient) \
		$(use_enable btpclient external-ell) \
		$(use_enable cups) \
		--disable-deprecated \
		$(use_enable experimental) \
		$(use_enable mesh) \
		$(use_enable mesh external-ell) \
		--disable-midi \
		$(use_enable obex) \
		$(use_enable readline client) \
		$(use_enable systemd) \
		$(use_enable udev) \
		$(use_enable udev sixaxis)
}

src_install() {
		emake DESTDIR="${D}" install

		# Only install extra-tools when relevant USE flag is enabled
		if use extra-tools; then
			ewarn "Upstream doesn't support using this tools and their bugs are"
			ewarn "likely to be ignored forever, also that tools can break"
			ewarn "without previous announcement."
			ewarn "Upstream also states all this tools are not really needed,"
			ewarn "then, if you still need to rely on them, you must ask them"
			ewarn "to either install that tool by default or add the needed"
			ewarn "functionality to the existing 'official' tools."
			ewarn "Please report this issues to:"
			ewarn "http://www.bluez.org/development/lists/"

			# Upstream doesn't install this, bug #524640
			# http://permalink.gmane.org/gmane.linux.bluez.kernel/53115
			# http://comments.gmane.org/gmane.linux.bluez.kernel/54564
			dobin tools/btmgmt
			# gatttool is only built with readline, bug #530776
			# https://bugzilla.redhat.com/show_bug.cgi?id=1141909
			# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486
			# https://bugs.archlinux.org/task/37686
			dobin attrib/gatttool
			# https://bugzilla.redhat.com/show_bug.cgi?id=1699680
			dobin tools/avinfo
		fi

		# We need to ensure obexd can be spawned automatically by systemd
	# when user-session is enabled:
	# http://marc.info/?l=linux-bluetooth&m=148096094716386&w=2
	# https://bugs.gentoo.org/show_bug.cgi?id=577842
	# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=804908
	# https://bugs.archlinux.org/task/45816
	# https://bugzilla.redhat.com/show_bug.cgi?id=1318441
	# https://bugzilla.redhat.com/show_bug.cgi?id=1389347
	if use user-session && use systemd; then
		ln -s "${ED}"/usr/lib/systemd/user/obex.service "${ED}"/usr/lib/systemd/user/dbus-org.bluez.obex.service
	fi

	find "${D}" -name '*.la' -type f -delete || die

	keepdir /var/lib/bluetooth

	# Upstream don't want people to play with them
	# But we keep installing them due to 'historical' reasons
	insinto /etc/bluetooth
	local d
	for d in input network; do
		doins profiles/${d}/${d}.conf
	done
	# Setup auto enable as Fedora does for allowing to use
	# keyboards/mouse as soon as possible
	sed -i 's/#\[Policy\]$/\[Policy\]/; s/#AutoEnable=false/AutoEnable=true/' src/main.conf || die
	doins src/main.conf
}

pkg_postinst() {
	use udev && udev_reload
	systemd_reenable bluetooth.service
}
