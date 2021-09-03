# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic user

DESCRIPTION="a DHCP and DHCPv6 client."
HOMEPAGE="https://roy.marples.name/projects/dhcpcd/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/rsmarples/${PN}"
	inherit git-r3
else
	SNAPSHOT=18da9b9155a4967da8648760c2ec4bce63a55ff0
	SRC_URI="https://github.com/rsmarples/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +embedded ipv6 systemd udev"

filter-flags -Wl,-z,defs

src_configure() {
	local myconf=(
		--dbdir="${EPREFIX}"/var/lib/dhcpcd
		--libexecdir="${EPREFIX}"/usr/lib/dhcpcd
		--libdir="${EPREFIX}"/usr/lib
		--localstatedir="${EPREFIX}/var"
		--prefix="${EPREFIX}"
		--with-hook=ntp.conf
		$(use_enable debug)
		$(use_enable embedded)
		$(use_enable ipv6)
		--enable-privsep
		--rundir="${EPREFIX}"/var/run/dhcpcd
		--privsepuser=dhcpcd
		$(usex udev '' '--without-dev --without-udev')
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	keepdir /var/lib/dhcpcd

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi
}

pkg_preinst() {
	enewgroup dhcpcd 67
	enewuser dhcpcd 67 -1 /var/empty dhcpcd
}
