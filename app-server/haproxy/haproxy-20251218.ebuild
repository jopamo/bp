# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user toolchain-funcs flag-o-matic linux-info

DESCRIPTION="A TCP/HTTP reverse proxy for high availability environments"
HOMEPAGE="http://haproxy.1wt.eu"
SNAPSHOT=8aef5bec1ef57eac449298823843d6cc08545745
SRC_URI="https://github.com/haproxy/haproxy/archive/${SNAPSHOT}.tar.gz -> haproxy-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/haproxy-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="crypt net_ns pcre2 pcre2-jit ssl systemd tools vim-syntax zlib lua 51degrees wurfl"

DEPEND="
    pcre2? (
        lib-core/libpcre2
        pcre2-jit? ( lib-core/libpcre2 )
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

haproxy_emake() {
    emake \
        CFLAGS="${CFLAGS}" \
        LDFLAGS="${LDFLAGS}" \
        USE_PCRE_JIT=0 \
        USE_PCRE=0 \
        CC="$(tc-getCC)" \
        "$@"
}

src_compile() {
    local -a args=(
        TARGET=linux-glibc
        USE_GETADDRINFO=1
        USE_TFO=1
    )

    local mappings=(
        "crypt=LIBCRYPT"
        "net_ns=NS"
        "ssl=OPENSSL"
        "zlib=ZLIB"
        "lua=LUA"
        "51degrees=51DEGREES"
        "wurfl=WURFL"
    )
    local map
    for map in "${mappings[@]}"; do
        local use_flag=${map%=*}
        local make_option=${map#*=}
        args+=( "$(haproxy_use "${use_flag}" "${make_option}")" )
    done

    append-cflags -fno-strict-aliasing

    haproxy_emake "${args[@]}"

    if use systemd; then
        emake -C admin/systemd SBINDIR=/usr/sbin
    fi

    if use tools; then
        haproxy_emake "${args[@]}" admin/{halog/halog,iprange/ip{,6}range}
    fi
}

src_install() {
    dobin haproxy

    if use systemd; then
        insinto /usr/lib/systemd/system
        insopts -m 0644
        doins admin/systemd/haproxy.service
    fi

    if use tools; then
        dobin admin/halog/halog
        newbin admin/iprange/iprange haproxy_iprange
        newbin admin/iprange/ip6range haproxy_ip6range
    fi
}
