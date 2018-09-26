# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit linux-info multilib python-any-r1 systemd autotools \
	user toolchain-funcs versionator virtualx udev multilib-minimal git-r3

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"
EGIT_REPO_URI="https://github.com/NetworkManager/NetworkManager.git"
EGIT_BRANCH=nm-1-10

LICENSE="GPL-2+"
SLOT="0" # add subslot if libnm-util.so.2 or libnm-glib.so.4 bumps soname version

IUSE="audit bluetooth +dhcpcd gnutls json kernel_linux +nss resolvconf systemd teamd test +wext +wifi"

REQUIRED_USE="
	wext? ( wifi )
	^^ ( nss gnutls )
	?? ( systemd )
"

KEYWORDS="amd64 arm64 x86"

COMMON_DEPEND="
	>=sys-app/dbus-1.2[${MULTILIB_USEDEP}]
	>=lib-dev/dbus-glib-0.100[${MULTILIB_USEDEP}]
	>=lib-dev/glib-2.37.6:2[${MULTILIB_USEDEP}]
	>=lib-dev/libnl-3.2.8:3=[${MULTILIB_USEDEP}]
	lib-net/libndp[${MULTILIB_USEDEP}]
	>=app-net/curl-7.24
	app-net/iputils
	sys-app/util-linux[${MULTILIB_USEDEP}]
	lib-sys/readline:0=
	>=sys-app/systemd-175:=[${MULTILIB_USEDEP}]
	audit? ( sys-app/audit )
	bluetooth? ( >=app-net/bluez-5 )
	dhcpcd? ( app-net/dhcpcd )
	gnutls? (
		lib-dev/libgcrypt:0=[${MULTILIB_USEDEP}]
		>=lib-net/gnutls-2.12:=[${MULTILIB_USEDEP}] )
	json? ( lib-dev/jansson[${MULTILIB_USEDEP}] )
	nss? ( >=lib-dev/nss-3.11:=[${MULTILIB_USEDEP}] )
	resolvconf? ( lib-net/openresolv )
	systemd? ( >=sys-app/systemd-209:0= )
	teamd? (
		lib-dev/jansson
		>=app-net/libteam-1.9
	)
"
RDEPEND="${COMMON_DEPEND}
	|| (
		app-net/iputils[arping(+)]
		app-net/arping
	)
	wifi? ( >=app-net/wpa_supplicant-0.7.3-r3[dbus] )
"
DEPEND="${COMMON_DEPEND}
	lib-dev/glib
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	>=sys-kernel/stable-sources-2.6.29
	dev-util/pkgconfig[${MULTILIB_USEDEP}]
"

pkg_setup() {
	enewgroup plugdev
	if use test; then
		python-any-r1_pkg_setup
	fi
}

src_prepare() {
	sed -i -e /^autoreconf/d autogen.sh || die
	NOCONFIGURE=1 ${S}/autogen.sh || die

	eapply_user
	eautoreconf
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-more-warnings
		--disable-static
		--localstatedir=/var
		--enable-lto
		--disable-config-plugin-ibft
		--disable-ifnet
		--without-netconfig
		--with-dbus-sys-dir=/etc/dbus-1/system.d
		--with-libnm-glib
		--with-udev-dir="$(get_udevdir)"
		--with-config-plugins-default=keyfile
		$(multilib_native_enable concheck)
		--with-crypto=$(usex nss nss gnutls)
		--with-session-tracking=$(multilib_native_usex systemd systemd )
		--with-suspend-resume=$(multilib_native_usex systemd systemd )
		$(multilib_native_use_with audit libaudit)
		$(multilib_native_use_enable bluetooth bluez5-dun)
		$(use_with dhcpcd)
		--disable-introspection
		$(use_enable json json-validation)
		--disable-ppp
		--enable-polkit=disabled
		--disable-ovs
		--without-iptables
		$(multilib_native_use_with resolvconf)
		$(multilib_native_use_with systemd systemd-journal)
		$(multilib_native_use_enable teamd teamdctl)
		$(multilib_native_use_enable test tests)
		--without-valgrind
		$(multilib_native_use_with wext)
		$(multilib_native_use_enable wifi)
	)

	use systemd && myconf+=( --with-systemdsystemunitdir="$(systemd_get_systemunitdir)" )

	if multilib_is_native_abi; then
		# work-around man out-of-source brokenness, must be done before configure
		ln -s "${S}/docs" docs || die
		ln -s "${S}/man" man || die
	fi

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_compile() {
	if multilib_is_native_abi; then
		emake
	else
		local targets=(
			libnm/libnm.la
			libnm-util/libnm-util.la
			libnm-glib/libnm-glib.la
			libnm-glib/libnm-glib-vpn.la
		)
		emake "${targets[@]}"
	fi
}

multilib_src_test() {
	if use test && multilib_is_native_abi; then
		python_setup
		virtx emake check
	fi
}

multilib_src_install() {
		default
		keepdir /var/lib/NetworkManager
}
