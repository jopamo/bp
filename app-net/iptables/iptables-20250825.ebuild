# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs autotools flag-o-matic

DESCRIPTION="Linux kernel firewall, NAT and packet mangling tools"
HOMEPAGE="http://www.netfilter.org/projects/iptables/"
SNAPSHOT=c3d5053db05f99bd72219aebeefc7fb0195ac041
SRC_URI="https://github.com/1g4-mirror/iptables/archive/${SNAPSHOT}.tar.gz -> iptables-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/iptables-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0/12"
KEYWORDS="amd64 arm64"

IUSE="conntrack ipv6 netlink nftables pcap static-libs"

RDEPEND="
	conntrack? ( >=lib-net/libnetfilter_conntrack-1.0.6 )
	netlink? ( lib-net/libnfnetlink )
	nftables? (
		>=lib-net/libmnl-1.0:0=
		>=lib-net/libnftnl-1.0.5:0=
	)
	pcap? ( lib-net/libpcap )
"
DEPEND="${RDEPEND}
	virtual/linux-sources
	app-dev/pkgconf
	nftables? (
		app-build/flex
		app-build/bison
	)
"

src_prepare() {
	# use the saner headers from the kernel
	rm -f include/linux/{kernel,types}.h

	default
	eautoreconf
}

src_configure() {
	tc-export AR

	# Hack around struct mismatches between userland & kernel for some ABIs. #472388
	use amd64 && [[ ${ABI} == "x32" ]] && append-flags -fpack-struct

	sed -i \
		-e "/nfnetlink=[01]/s:=[01]:=$(usex netlink 1 0):" \
		-e "/nfconntrack=[01]/s:=[01]:=$(usex conntrack 1 0):" \
		configure || die

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-devel
		--enable-shared
		$(use_enable nftables)
		$(use_enable pcap bpf-compiler)
		$(use_enable pcap nfsynproxy)
		$(use_enable static-libs static)
		$(use_enable ipv6)
	)
	econf "${myconf[@]}"
}

src_compile() {
	# Deal with parallel build errors.
	use nftables && emake -C iptables xtables-config-parser.h
	emake V=1
}

src_install() {
	default

	dobin iptables/iptables-apply
	dosym iptables-apply /usr/sbin/ip6tables-apply
	doman iptables/iptables-apply.8

	insinto /usr/include
	doins include/iptables.h $(use ipv6 && echo include/ip6tables.h)
	insinto /usr/include/iptables
	doins include/iptables/internal.h
}
