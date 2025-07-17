# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"
SNAPSHOT=b4a22ad2a9b7cf411161248f29c2d588cee11dea
SRC_URI="https://github.com/NetworkManager/NetworkManager/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/NetworkManager-${SNAPSHOT}

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nmtui systemd test"

DEPEND="
	app-net/curl
	app-net/iproute2
	app-net/wpa_supplicant[dbus]
	lib-dev/newt
	lib-net/libndp
"

src_configure() {
	filter-flags -Wl,-z,defs -flto*

	local emesonargs=(
		$(meson_use nmtui)
		-Dcrypto=gnutls
		-Dintrospection=false
		-Dlibaudit=no
		-Dlibpsl=false
		-Dmodem_manager=false
		-Dovs=false
		-Dpolkit=false
		-Dppp=false
		-Dqt=false
		-Dselinux=false
		-Dwext=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	keepdir /var/lib/NetworkManager

	insinto /etc/NetworkManager
	doins "${FILESDIR}"/NetworkManager.conf
}
