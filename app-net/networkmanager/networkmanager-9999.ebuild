# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson flag-o-matic

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/NetworkManager/NetworkManager"
	inherit git-r3
else
	SNAPSHOT=41937748d825f143d9f283cf2de6bb12f7a33387
	SRC_URI="https://github.com/NetworkManager/NetworkManager/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/NetworkManager-${SNAPSHOT}
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+nmtui systemd test"

COMMON_DEPEND="
	app-core/dbus
	lib-dev/dbus-glib
	lib-live/glib
	lib-dev/libnl
	lib-net/libndp
	app-net/curl
	app-net/iputils
	app-core/util-linux
	lib-core/readline
	virtual/service-manager
	lib-core/libgcrypt
	lib-net/gnutls
"
RDEPEND="${COMMON_DEPEND}
	app-net/iputils[arping(+)]
	app-net/wpa_supplicant[dbus]
"
DEPEND="${COMMON_DEPEND}
	lib-live/glib
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	sys-kernel/linux-headers
	dev-util/pkgconf
	lib-dev/newt
	dev-python/pygobject
"

filter-flags -Wl,-z,defs

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

src_install() {
	meson_src_install
	keepdir /var/lib/NetworkManager
}
