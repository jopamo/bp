# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/NetworkManager/NetworkManager"
	inherit git-r3
else
	SNAPSHOT=6430a7d70c22e584d020810b7da27778ab0c9892
	SRC_URI="https://github.com/NetworkManager/NetworkManager/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/NetworkManager-${SNAPSHOT}
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+nmtui systemd test"

COMMON_DEPEND="
	app-core/dbus
	app-core/util-linux
	app-net/curl
	app-net/iputils
	lib-core/libgcrypt
	lib-core/readline
	lib-dev/dbus-glib
	lib-dev/libnl
	lib-live/glib
	lib-live/libndp
	lib-net/gnutls
	virtual/service-manager
"
RDEPEND="${COMMON_DEPEND}
	app-net/iputils[arping(+)]
	app-net/wpa_supplicant[dbus]
"
DEPEND="${COMMON_DEPEND}
	app-build/gettext
	app-dev/gtk-doc-am
	app-dev/intltool
	app-dev/pkgconf
	app-kernel/linux-headers
	dev-python/pygobject
	lib-dev/newt
	lib-live/glib
"

filter-flags -Wl,-z,defs

src_configure() {
	local emesonargs=(
		$(meson_use nmtui)
		-Dcrypto=gnutls
		-Dintrospection=false
		-Djson_validation=false
		-Dlibaudit=no
		-Dlibpsl=false
		-Dmodem_manager=false
		-Dovs=false
		-Dpolkit=false
		-Dppp=false
		-Dprefix-default="${EPREFIX}"
		-Dqt=false
		-Dselinux=false
		-Dwext=false
		)
		meson_src_configure
}

src_install() {
	meson_src_install
	keepdir /var/lib/NetworkManager
}
