# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd autotools

DESCRIPTION="Thermal daemon for Intel architectures"
HOMEPAGE="https://01.org/linux-thermal-daemon"
SRC_URI="https://github.com/01org/thermal_daemon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

S=${WORKDIR}/thermal_daemon-${PV}

CDEPEND="lib-dev/dbus-glib
	lib-dev/libxml2"
DEPEND="${CDEPEND}
	sys-app/sed"
RDEPEND="${CDEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-systemdsystemunitdir=$(systemd_get_systemunitdir)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
