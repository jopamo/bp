# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user toolchain-funcs flag-o-matic linux-info

DESCRIPTION="A TCP/HTTP reverse proxy for high availability environments"
HOMEPAGE="http://haproxy.1wt.eu"
SRC_URI="https://www.haproxy.org/download/$(ver_cut 1-2)/src/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+crypt net_ns +pcre pcre-jit pcre2 pcre2-jit ssl
systemd +tools vim-syntax +zlib lua 51degrees wurfl"

DEPEND="
	pcre? (
		lib-core/libpcre
		pcre-jit? ( lib-core/libpcre[jit] )
	)
	pcre2? (
		lib-core/libpcre2
		pcre2-jit? ( lib-core/libpcre2[jit] )
	)
	ssl? ( virtual/ssl )
	zlib? ( lib-core/zlib )
	lua? ( app-lang/lua )
"

haproxy_use() {
	(( $# != 2 )) && die "${FUNCNAME} <USE flag> <make option>"

	usex "${1}" "USE_${2}=1" "USE_${2}="
}

pkg_setup() {
	enewgroup haproxy
	enewuser haproxy -1 -1 -1 haproxy

	if use net_ns; then
		CONFIG_CHECK="~NET_NS"
		linux-info_pkg_setup
	fi
}

src_compile() {
	local -a args=(
		TARGET=linux-glibc
		USE_GETADDRINFO=1
		USE_TFO=1
	)

	args+=( $(haproxy_use crypt LIBCRYPT) )
	args+=( $(haproxy_use net_ns NS) )
	args+=( $(haproxy_use pcre PCRE) )
	args+=( $(haproxy_use pcre-jit PCRE_JIT) )
	args+=( $(haproxy_use ssl OPENSSL) )
	args+=( $(haproxy_use zlib ZLIB) )
	args+=( $(haproxy_use lua LUA) )
	args+=( $(haproxy_use 51degrees 51DEGREES) )
	args+=( $(haproxy_use wurfl WURFL) )
	args+=( $(haproxy_use systemd SYSTEMD) )

	# For now, until the strict-aliasing breakage will be fixed
	append-cflags -fno-strict-aliasing

	emake \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CC=$(tc-getCC) \
		${args[@]}

	use systemd && emake -C admin/systemd SBINDIR=/usr/sbin

	if use tools ; then
		emake \
			CFLAGS="${CFLAGS}" \
			LDFLAGS="${LDFLAGS}" \
			CC=$(tc-getCC) \
			${args[@]} \
			admin/{halog/halog,iprange/ip{,6}range}
	fi
}

src_install() {
	dobin haproxy

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins admin/systemd/haproxy.service
	fi

	if use tools ; then
		dobin admin/halog/halog
		newbin admin/iprange/iprange haproxy_iprange
		newbin admin/iprange/ip6range haproxy_ip6range
	fi
}
