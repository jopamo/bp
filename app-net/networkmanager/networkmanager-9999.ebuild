# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info multilib systemd flag-o-matic user toolchain-funcs versionator virtualx udev multilib-minimal git-r3 meson

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"
EGIT_REPO_URI="https://github.com/NetworkManager/NetworkManager.git"

LICENSE="GPL-2+"
SLOT="0" # add subslot if libnm-util.so.2 or libnm-glib.so.4 bumps soname version

IUSE="audit bluetooth +dhcpcd gnutls json kernel_linux +nmtui +nss resolvconf systemd teamd test +wext +wifi"

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
	lib-dev/newt
	dev-python/pygobject
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_configure() {
	local emesonargs=(
		$(meson_use nmtui)
		-Dprefix-default="${EPREFIX}"
		-Dintrospection=false
		-Dselinux=false
		-Dlibaudit=no
		-Dpolkit=false
		-Dppp=false
		-Dmodem_manager=false
		-Dlibpsl=false
		-Dqt=false
		-Dwext=false
		-Dovs=false
		)
		meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_test() {
	meson_src_test
}

src_install() {
	meson_src_install
	rm -rf ${ED}/usr/share/doc ${ED}/var/lib
}
