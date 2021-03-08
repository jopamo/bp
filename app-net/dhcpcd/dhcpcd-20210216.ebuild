# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic systemd user

DESCRIPTION="a DHCP and DHCPv6 client."
HOMEPAGE="https://roy.marples.name/projects/dhcpcd/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/rsmarples/${PN}"
	inherit git-r3
else
	SNAPSHOT=f322b5a1ae427c3f8be08448564ee5b1b5ef6683
	SRC_URI="https://github.com/rsmarples/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +embedded ipv6 systemd udev"

filter-flags -Wl,-z,defs -flto\=\*

src_configure() {
	local myeconfargs=(
		--dbdir="${EPREFIX}"/var/lib/dhcpcd
		--libexecdir="${EPREFIX}"/usr/lib/dhcpcd
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
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	keepdir /var/lib/dhcpcd

	if use systemd; then
		systemd_dounit "${FILESDIR}"/dhcpcd.service
	fi
}

pkg_preinst() {
	enewgroup dhcpcd 67
	enewuser dhcpcd 67 -1 /var/empty dhcpcd
}
