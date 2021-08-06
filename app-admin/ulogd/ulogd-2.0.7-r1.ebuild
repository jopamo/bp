# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info user flag-o-matic

DESCRIPTION="A userspace logging daemon for netfilter/iptables related logging"
HOMEPAGE="https://netfilter.org/projects/ulogd/index.html"
SRC_URI="https://www.netfilter.org/projects/ulogd/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="json mysql nfacct +nfct +nflog pcap postgres sqlite systemd"

DEPEND="
	|| ( app-net/iptables app-net/nftables )
	lib-net/libnfnetlink
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
	sqlite? ( lib-sys/sqlite )
"

PATCHES=(
		"${FILESDIR}"/00.9d9ea2cd70a369a7f665a322e6c53631e01a2570.patch
		"${FILESDIR}"/01.675e762091380590f78ff07a94a25caa459b786b.patch
		"${FILESDIR}"/04.63135e73fd878cb71b1eebf8e877c4d4c34feba7.patch
		"${FILESDIR}"/05.48fe3eacbacd62865bb98b2faeacbee39084b8d6.patch
		"${FILESDIR}"/06.65c02cc9ae969677756f30b69a3637c678b7c5b4.patch
)

filter-flags -Wl,-z,defs

pkg_setup() {
	linux-info_pkg_setup

	enewgroup ulogd
	enewuser ulogd -1 -1 /var/log/ulogd ulogd
}

src_configure() {
	append-lfs-flags

	local myconf=(
		--without-dbi
		$(use_with json jansson)
		$(use_enable nfacct)
		$(use_enable nfct)
		$(use_enable nflog)
		$(use_with mysql)
		$(use_with pcap)
		$(use_with postgres pgsql)
		$(use_with sqlite)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	insinto /etc
	doins ${PN}.conf
	fowners root:ulogd /etc/${PN}.conf
	fperms 640 /etc/${PN}.conf

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi

	diropts -o ulogd -g ulogd
	keepdir /var/log/ulogd
}
