# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="https://wiki.linuxfoundation.org/networking/iproute2"
SNAPSHOT=1c344b988c1475dc308335afb9ce528b7af3b8d8
SRC_URI="https://github.com/iproute2/iproute2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/iproute2-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps elf iptables"

# bison/flex are used by tc and uapi parsers
# libmnl is required by recent iproute2 for netlink attr helpers
# libcap is optional behind USE=caps
DEPEND="
	app-build/bison
	app-build/flex
	app-compression/xz-utils
	virtual/linux-sources
	lib-net/libbpf
	lib-net/libmnl
	caps? ( lib-core/libcap )
	elf? ( virtual/libelf )
	elibc_glibc? ( lib-dev/libbsd )
	iptables? ( app-net/iptables )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/iproute2-5.7.0-mix-signal.h-include.patch
	"${FILESDIR}"/iproute2-mtu.patch
)

doecho() {
	echo "${@}"
	"${@}" || die
}

src_prepare() {
	# trim problematic flags from some toolchains and keep lto objects fat for ar/ranlib friendliness
	filter-flags -Wl,-z,defs -flto*
	append-flags -ffat-lto-objects

	# keep kernel uapi ipv6 structs from being redefined by glibc headers
	append-flags -D__UAPI_DEF_IN6_ADDR=0 -D__UAPI_DEF_IN6_ADDR_ALT=0 -D__UAPI_DEF_SOCKADDR_IN6=0 -D__UAPI_DEF_IPV6_MREQ=0

	if use elibc_musl; then
		# prefer musl native functions and avoid libbsd fallback
		eapply "${FILESDIR}"/iproute2-6.8.0-configure-nomagic-nolibbsd.patch
		eapply "${FILESDIR}"/iproute2-6.8.0-disable-libbsd-fallback.patch

		# guard SIOCGSTAMP redefs on musl to silence warnings without breaking non-musl
		sed -Ei \
			-e 's|^[[:space:]]*#define[[:space:]]+SIOCGSTAMP[[:space:]]+SIOCGSTAMP_OLD$|#ifndef SIOCGSTAMP\
#define SIOCGSTAMP SIOCGSTAMP_OLD\
#endif|' \
			-e 's|^[[:space:]]*#define[[:space:]]+SIOCGSTAMPNS[[:space:]]+SIOCGSTAMPNS_OLD$|#ifndef SIOCGSTAMPNS\
#define SIOCGSTAMPNS SIOCGSTAMPNS_OLD\
#endif|' \
			include/uapi/linux/sockios.h || die

		# add <limits.h> for UINT_MAX users where some configurations miss an include
		if ! grep -q '^#include[[:space:]]\+<limits\.h>' lib/utils_math.c; then
			sed -i '/^#include[[:space:]]\+"utils\.h"/a #include <limits.h>' lib/utils_math.c || die
		fi

		if ! grep -q '^#include[[:space:]]\+<limits\.h>' tc/tc_core.c; then
			if grep -q '^#include[[:space:]]\+<linux/atm\.h>' tc/tc_core.c; then
				sed -i '/^#include[[:space:]]\+<linux\/atm\.h>/a #include <limits.h>' tc/tc_core.c || die
			else
				sed -i '0,/^#include/s//&\
#include <limits.h>/' tc/tc_core.c || die
			fi
		fi
	fi

	default

	# echo -n is not posix compliant
	sed -i 's@echo -n@printf@' configure || die

	# toolchain and dirs unification
	sed -i \
		-e '/^CC :\?=/d' \
		-e "/^LIBDIR/s:=.*:=/lib:" \
		-e "s|-O2|${CFLAGS} ${CPPFLAGS}|" \
		-e "/^HOSTCC/s:=.*:= $(tc-getBUILD_CC):" \
		-e "/^DBM_INCLUDE/s:=.*:=${T}:" \
		Makefile || die

	# fix ss TCPI_OPT_ECN_SEEN value mismatch reported by some kernels
	sed -i 's:TCPI_OPT_ECN_SEEN:16:' misc/ss.c || die

	# ensure global LDLIBS has required libs once without duplication
	grep -q -- '-lmnl' Makefile || sed -i '/^LDLIBS[[:space:]]*+=/ s/$/ -lmnl/' Makefile || die
	grep -q -- '-ltirpc' Makefile || sed -i '/^LDLIBS[[:space:]]*+=/ s/$/ -ltirpc -lbpf/' Makefile || die
	if use caps; then
		grep -q -- '-lcap' Makefile || sed -i '/^LDLIBS[[:space:]]*+=/ s/$/ -lcap/' Makefile || die
	fi

	# optionally disable capability code paths when USE=-caps if upstream exposes a define
	# harmless if the symbol is absent
	sed -i 's/^#define USE_CAP/\/* #define USE_CAP *\//' include/config.h 2>/dev/null || true
}

src_configure() {
	tc-export AR CC PKG_CONFIG

	# detect setns for netns helpers
	local setns
	pushd "${T}" >/dev/null || die
	printf '#include <sched.h>\nint main(){return setns(0, 0);}\n' > test.c
	${CC} ${CFLAGS} ${CPPFLAGS} -D_GNU_SOURCE ${LDFLAGS} test.c >&/dev/null && setns=y || setns=n
	echo 'int main(){return 0;}' > test.c
	${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} test.c -lresolv >&/dev/null || sed -i '/^LDLIBS/s:-lresolv::' "${S}"/Makefile
	popd >/dev/null || die

	doecho ./configure
}

src_compile() {
	# prefer pkg-config hints when available and fall back to bare libs
	local pc_mnl="$(pkg-config --libs libmnl 2>/dev/null || echo -lmnl)"
	local pc_cap=""
	use caps && pc_cap="$(pkg-config --libs libcap 2>/dev/null || echo -lcap)"

	emake V=1 NETNS_RUN_DIR=/run/netns \
		MNL_LIBS="${pc_mnl}" \
		LIBCAP_LIBS="${pc_cap}"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		LIBDIR="${EPREFIX}"/usr/lib \
		BINDIR="${EPREFIX}"/usr/bin \
		SBINDIR="${EPREFIX}"/usr/bin \
		CONFDIR="${EPREFIX}"/etc/iproute2 \
		DOCDIR="${EPREFIX}"/usr/share/doc/${PF} \
		MANDIR="${EPREFIX}"/usr/share/man \
		ARPDDIR="${EPREFIX}"/var/lib/arpd \
		install

	if [[ -d "${ED}"/var/lib/arpd ]]; then
		rmdir --ignore-fail-on-non-empty -p "${ED}"/var/lib/arpd || die
	fi
}
