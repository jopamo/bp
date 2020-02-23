# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pam user git-r3 autotools systemd

DESCRIPTION="small SSH 2 client/server designed for small memory environments"
HOMEPAGE="https://matt.ucc.asn.au/dropbear/dropbear.html"
EGIT_REPO_URI="https://github.com/mkj/dropbear.git"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bsdpty pam +shadow static +syslog systemd zlib"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-harden
		$(use_enable zlib)
		$(use_enable pam)
		$(use_enable !bsdpty openpty)
		$(use_enable shadow)
		$(use_enable static)
		$(use_enable syslog)
	)
	econf "${myconf[@]}"
}

src_install() {
	emake DESTDIR="${D}" install

	pamd_mimic system-remote-login dropbear auth account password session

	use systemd && systemd_dounit "${FILESDIR}"/${PN}.service
}

pkg_preinst() {
	enewgroup sshd 22
	enewuser sshd 22 -1 /var/empty sshd
}
