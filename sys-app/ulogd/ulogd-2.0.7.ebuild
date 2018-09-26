# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info systemd user

DESCRIPTION="A userspace logging daemon for netfilter/iptables related logging"
HOMEPAGE="https://netfilter.org/projects/ulogd/index.html"
SRC_URI="https://www.netfilter.org/projects/ulogd/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="dbi doc json mysql nfacct +nfct +nflog pcap postgres selinux sqlite"

COMMON_DEPEND="
	|| ( sys-app/iptables sys-app/nftables )
	>=lib-net/libnfnetlink-1.0.1
	dbi? ( dev-db/libdbi )
	json? ( lib-dev/jansson )
	nfacct? (
		>=lib-net/libmnl-1.0.3
		>=lib-net/libnetfilter_acct-1.0.1
	)
	nfct? ( >=lib-net/libnetfilter_conntrack-1.0.2 )
	nflog? ( >=lib-net/libnetfilter_log-1.0.0 )
	mysql? ( virtual/mysql )
	pcap? ( lib-net/libpcap )
	postgres? ( dev-db/postgresql:= )
	sqlite? ( lib-sys/sqlite:3 )
"
DEPEND="${COMMON_DEPEND}
	doc? (
		app-text/linuxdoc-tools
		app-text/texlive-core
		app-textlive/texlive-fontsrecommended
		virtual/latex-base
	)
"
RDEPEND="${COMMON_DEPEND}
	selinux? ( sec-policy/selinux-ulogd )
"

PATCHES=(
		"${FILESDIR}/9d9ea2cd70a369a7f665a322e6c53631e01a2570.patch"
		)

pkg_setup() {
	linux-info_pkg_setup

	if use nfacct && kernel_is lt 3 3 0; then
		ewarn "NFACCT input plugin requires a kernel >= 3.3."
	fi

	enewgroup ulogd
	enewuser ulogd -1 -1 /var/log/ulogd ulogd
}

src_configure() {
	append-lfs-flags
	local myeconfargs=(
		$(use_with dbi)
		$(use_with json jansson)
		$(use_enable nfacct)
		$(use_enable nfct)
		$(use_enable nflog)
		$(use_with mysql)
		$(use_with pcap)
		$(use_with postgres pgsql)
		$(use_with sqlite)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	default

	insinto /etc
	doins ${PN}.conf
	fowners root:ulogd /etc/${PN}.conf
	fperms 640 /etc/${PN}.conf

	systemd_dounit "${FILESDIR}/${PN}.service"

	diropts -o ulogd -g ulogd
	keepdir /var/log/ulogd
}
