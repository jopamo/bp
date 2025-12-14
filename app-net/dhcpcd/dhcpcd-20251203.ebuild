# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic user

DESCRIPTION="A fully featured, yet light weight RFC2131 compliant DHCP client"
HOMEPAGE="https://github.com/NetworkConfiguration/dhcpcd/ https://roy.marples.name/projects/dhcpcd/"
SNAPSHOT=a16c625bb9e7ca3d7318e55b7af1161b006487af
SRC_URI="https://github.com/NetworkConfiguration/dhcpcd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dhcpcd-${SNAPSHOT}"

LICENSE="BSD-2 BSD ISC MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug embedded ipv6 systemd udev"

src_configure() {
	filter-flags -Wl,-z,defs

	local myeconfargs=(
		--dbdir="${EPREFIX}/var/lib/dhcpcd"
		--libexecdir="${EPREFIX}/usr/lib/dhcpcd"
		--localstatedir="${EPREFIX}/var"
		--prefix="${EPREFIX}"
		$(use_enable debug)
		$(use_enable embedded)
		$(use_enable ipv6)
		--enable-privsep
		--rundir="${EPREFIX}/run/dhcpcd"
		--privsepuser=dhcpcd
		$(usex udev '' '--without-dev --without-udev')
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	keepdir /var/lib/dhcpcd

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/dhcpcd.service
	fi
}

pkg_preinst() {
	enewgroup dhcpcd 67
	enewuser dhcpcd 67 -1 -1 dhcpcd
}
