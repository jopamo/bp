# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="A set of co-operative tools that make networking simple and straightforward"
HOMEPAGE="https://wiki.gnome.org/Projects/NetworkManager"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/NetworkManager/NetworkManager"
	inherit git-r3
else
	SNAPSHOT=94756668f959cc0c7024fcaf2cfd122a7e3d6ab3
	SRC_URI="https://github.com/NetworkManager/NetworkManager/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/NetworkManager-${SNAPSHOT}
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+nmtui systemd test"

DEPEND="
	app-net/curl
	app-net/iproute2
	app-net/wpa_supplicant[dbus]
	lib-dev/newt
	lib-net/libndp
"

src_configure() {
	filter-flags -Wl,-z,defs

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
