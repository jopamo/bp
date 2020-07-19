# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson flag-o-matic

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/NetworkManager/NetworkManager"
	inherit git-r3
else
	SNAPSHOT=3f140afdfce2ed76ede842587ce2298305b1c699
	SRC_URI="https://github.com/NetworkManager/NetworkManager/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+nmtui systemd test"

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
	virtual/service-manager
	lib-dev/libgcrypt:0=
	>=lib-net/gnutls-2.12:=
"
RDEPEND="${COMMON_DEPEND}
	|| (
		app-net/iputils[arping(+)]
		app-net/arping
	)
	>=app-net/wpa_supplicant-0.7.3-r3[dbus]
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

filter-flags -Wl,-z,defs -Wl,-z,relro

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
		-Djson_validation=false
		)
		meson_src_configure
}
