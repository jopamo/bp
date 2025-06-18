# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info user flag-o-matic autotools

DESCRIPTION="A userspace logging daemon for netfilter/iptables related logging"
HOMEPAGE="https://netfilter.org/projects/ulogd/index.html"

SNAPSHOT=1ab0c1b1fd3f598b671455ad38c52d1dce96bbba
SRC_URI="https://github.com/1g4-mirror/ulogd2/archive/${SNAPSHOT}.tar.gz -> ulogd-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/ulogd2-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="json mysql nfacct +nfct +nflog pcap postgres sqlite systemd"

DEPEND="
	|| ( app-net/iptables app-net/nftables )
	lib-net/libnfnetlink
	json? ( lib-core/jansson )
	nfacct? (
		>=lib-net/libmnl-1.0.3
		>=lib-net/libnetfilter_acct-1.0.1
	)
	nfct? ( >=lib-net/libnetfilter_conntrack-1.0.2 )
	nflog? ( >=lib-net/libnetfilter_log-1.0.0 )
	mysql? ( virtual/mysql )
	pcap? ( lib-net/libpcap )
	postgres? ( dev-db/postgresql:= )
	sqlite? ( lib-core/sqlite )
"

PATCHES=(
		"${FILESDIR}/"
)

pkg_setup() {
	linux-info_pkg_setup

	enewgroup ulogd
	enewuser ulogd -1 -1 /var/log/ulogd ulogd
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	filter-flags -Wl,-z,defs

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
	doins ulogd.conf
	fowners root:ulogd /etc/ulogd.conf
	fperms 640 /etc/ulogd.conf

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/ulogd.service"
	fi

	diropts -o ulogd -g ulogd
	keepdir /var/log/ulogd
}
