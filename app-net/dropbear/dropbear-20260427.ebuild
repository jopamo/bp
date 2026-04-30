# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="small SSH 2 client/server designed for small memory environments"
HOMEPAGE="https://matt.ucc.asn.au/dropbear/dropbear.html"
SNAPSHOT=02bf2ec84b9d5c520787b193eff8d2e9a142c9d0
SRC_URI="https://github.com/mkj/dropbear/archive/${SNAPSHOT}.tar.gz -> dropbear-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dropbear-${SNAPSHOT}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bsdpty pam shadow static syslog systemd zlib"

src_prepare() {
	default

	sed -i 's/pam_start("sshd"/pam_start("dropbear"/' src/svr-authpam.c || die
}

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
		doins "${FILESDIR}/dropbear.service"
	fi
}
