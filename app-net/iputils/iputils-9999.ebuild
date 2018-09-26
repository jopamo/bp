# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit flag-o-matic toolchain-funcs fcaps git-r3

EGIT_REPO_URI="https://github.com/iputils/iputils.git"
KEYWORDS="amd64 arm64 x86"
DESCRIPTION="Network monitoring tools including ping and ping6"
HOMEPAGE="https://wiki.linuxfoundation.org/networking/iputils"

LICENSE="BSD GPL-2+ rdisc"
SLOT="0"
IUSE="+arping caps clockdiff doc gcrypt idn ipv6 libressl nettle +openssl rarpd rdisc SECURITY_HAZARD ssl static tftpd tracepath traceroute"

LIB_DEPEND="caps? ( lib-sys/libcap[static-libs(+)] )
	idn? ( lib-net/libidn[static-libs(+)] )
	ipv6? ( ssl? (
		gcrypt? ( lib-dev/libgcrypt:0=[static-libs(+)] )
		nettle? ( lib-dev/nettle[static-libs(+)] )
		openssl? (
			!libressl? ( lib-dev/openssl:0[static-libs(+)] )
			libressl? ( lib-dev/libressl[static-libs(+)] )
		)
	) )"
RDEPEND="arping? ( !app-net/arping )
	rarpd? ( !app-net/rarpd )
	traceroute? ( !app-net/traceroute )
	!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	sys-kernel/stable-sources
"

REQUIRED_USE="ipv6? ( ssl? ( ^^ ( gcrypt nettle openssl ) ) )"

src_prepare() {
	use SECURITY_HAZARD && PATCHES+=( "${FILESDIR}"/${PN}-20150815-nonroot-floodping.patch )

	default
}

src_configure() {
	use static && append-ldflags -static

	TARGETS=(
		ping
		$(for v in arping clockdiff rarpd rdisc tftpd tracepath ; do usev ${v} ; done)
	)
	if use ipv6 ; then
		TARGETS+=(
			$(usex traceroute 'traceroute6' '')
		)
	fi

	myconf=(
		USE_CRYPTO=no
		USE_GCRYPT=no
		USE_NETTLE=no
	)

	if use ipv6 && use ssl ; then
		myconf=(
			USE_CRYPTO=$(usex openssl)
			USE_GCRYPT=$(usex gcrypt)
			USE_NETTLE=$(usex nettle)
		)
	fi
}

src_compile() {
	tc-export CC
	emake \
		USE_CAP=$(usex caps) \
		USE_IDN=$(usex idn) \
		IPV4_DEFAULT=$(usex ipv6 'no' 'yes') \
		TARGETS="${TARGETS[*]}" \
		${myconf[@]}
}

src_install() {
	insinto /usr/bin
	dobin ping

	if use arping ; then
		dobin arping
	fi

	if use tracepath ; then
		dosbin tracepath
	fi

	local u
	for u in clockdiff rarpd rdisc tftpd ; do
		if use ${u} ; then
			case ${u} in
			clockdiff) dobin ${u};;
			*) dosbin ${u};;
			esac
		fi
	done

	if use traceroute && use ipv6 ; then
		dosbin traceroute6
	fi
}

pkg_postinst() {
	fcaps cap_net_raw \
		usr/bin/ping \
		$(usex arping 'usr/bin/arping' '') \
		$(usex clockdiff 'usr/bin/clockdiff' '')
}
