# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user

DESCRIPTION="small SSH 2 client/server designed for small memory environments"
HOMEPAGE="https://matt.ucc.asn.au/dropbear/dropbear.html"

SNAPSHOT=58e537e39d64aae19ad9a3ea36e1e6c990da8e61
SRC_URI="https://github.com/mkj/dropbear/archive/${SNAPSHOT}.tar.gz -> dropbear-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dropbear-${SNAPSHOT}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bsdpty pam +shadow static +syslog systemd zlib"

src_configure() {
	local myconf=(
		$(use_enable !bsdpty openpty)
		$(use_enable pam)
		$(use_enable shadow)
		$(use_enable static)
		$(use_enable syslog)
		$(use_enable zlib)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	if use pam; then
		insinto etc/pam.d
		insopts -m0644
		newins "${FILESDIR}/sshd.pam" dropbear
	fi

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi
}

pkg_preinst() {
	enewgroup sshd 22
	enewuser sshd 22 -1 /var/empty sshd
}
