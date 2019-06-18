# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"
EGIT_REPO_URI="https://github.com/NetworkManager/NetworkManager.git"

LICENSE="GPL-2+"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="gnutls json +nmtui systemd test +wext +wifi"

REQUIRED_USE="
	wext? ( wifi )
	^^ ( gnutls )
	?? ( systemd )
"

COMMON_DEPEND="
	>=sys-app/dbus-1.2
	>=lib-dev/dbus-glib-0.100
	>=lib-dev/glib-2.37.6:2
	>=lib-dev/libnl-3.2.8:3=
	lib-net/libndp
	>=app-net/curl-7.24
	app-net/iputils
	sys-app/util-linux
	lib-sys/readline:0=
	>=sys-app/systemd-175:=
	gnutls? (
		lib-dev/libgcrypt:0=
		>=lib-net/gnutls-2.12:= )
	json? ( lib-dev/jansson )
	systemd? ( >=sys-app/systemd-209:0= )
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
	sys-kernel/linux-headers
	dev-util/pkgconf
	lib-dev/newt
	dev-python/pygobject
"

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
		-Dcrypto=gnutls
		)
		meson_src_configure
}
