# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user toolchain-funcs flag-o-matic systemd linux-info git-r3

DESCRIPTION="A TCP/HTTP reverse proxy for high availability environments"
HOMEPAGE="http://haproxy.1wt.eu"
EGIT_REPO_URI="http://git.haproxy.org/git/haproxy-$(ver_cut 1).$(ver_cut 2).git"
EGIT_MIN_CLONE_TYPE=single

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="+crypt doc examples slz net_ns +pcre pcre-jit pcre2 pcre2-jit ssl
systemd +threads tools vim-syntax +zlib lua device-atlas 51degrees wurfl"

REQUIRED_USE="pcre-jit? ( pcre )
	pcre2-jit? ( pcre2 )
	pcre? ( !pcre2 )
	device-atlas? ( pcre )
	?? ( slz zlib )"

DEPEND="
	pcre? (
		lib-dev/libpcre
		pcre-jit? ( lib-dev/libpcre[jit] )
	)
	pcre2? (
		lib-dev/libpcre
		pcre2-jit? ( lib-dev/libpcre2[jit] )
	)
	ssl? ( lib-dev/libressl )
	slz? ( lib-dev/libslz:= )
	zlib? ( lib-sys/zlib )
	lua? ( dev-lang/lua:5.3 )
	device-atlas? ( lib-dev/device-atlas-api-c )"
RDEPEND="${DEPEND}"

CONTRIBS=( halog iprange )
CONTRIBS+=( ip6range spoa_example tcploop )
CONTRIBS+=( hpack )

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

	args+=( $(haproxy_use threads THREAD) )
	args+=( $(haproxy_use crypt LIBCRYPT) )
	args+=( $(haproxy_use net_ns NS) )
	args+=( $(haproxy_use pcre PCRE) )
	args+=( $(haproxy_use pcre-jit PCRE_JIT) )
	args+=( $(haproxy_use ssl OPENSSL) )
	args+=( $(haproxy_use slz SLZ) )
	args+=( $(haproxy_use zlib ZLIB) )
	args+=( $(haproxy_use lua LUA) )
	args+=( $(haproxy_use 51degrees 51DEGREES) )
	args+=( $(haproxy_use device-atlas DEVICEATLAS) )
	args+=( $(haproxy_use wurfl WURFL) )
	args+=( $(haproxy_use systemd SYSTEMD) )

	# For now, until the strict-aliasing breakage will be fixed
	append-cflags -fno-strict-aliasing

	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC=$(tc-getCC) ${args[@]}
	emake -C contrib/systemd SBINDIR=/usr/sbin

	if use tools ; then
		for contrib in ${CONTRIBS[@]} ; do
			emake -C contrib/${contrib} \
				CFLAGS="${CFLAGS}" OPTIMIZE="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC=$(tc-getCC) ${args[@]}
		done
	fi
}

src_install() {
	dosbin haproxy
	dosym /usr/sbin/haproxy /usr/bin/haproxy

	systemd_dounit contrib/systemd/haproxy.service

	# The errorfiles are used by upstream defaults.
	insinto /etc/haproxy/errors/
	doins examples/errorfiles/*

	if use tools ; then
		has halog "${CONTRIBS[@]}" && dobin contrib/halog/halog
		has "iprange" "${CONTRIBS[@]}" && newbin contrib/iprange/iprange haproxy_iprange
		has "ip6range" "${CONTRIBS[@]}" && newbin contrib/ip6range/ip6range haproxy_ip6range
		has "spoa_example" "${CONTRIBS[@]}" && newbin contrib/spoa_example/spoa haproxy_spoa_example
		has "spoa_example" "${CONTRIBS[@]}" && newdoc contrib/spoa_example/README README.spoa_example
		has "tcploop" "${CONTRIBS[@]}" && newbin contrib/tcploop/tcploop haproxy_tcploop
		has "hpack" "${CONTRIBS[@]}" && newbin contrib/hpack/gen-rht haproxy_hpack
	fi
}
