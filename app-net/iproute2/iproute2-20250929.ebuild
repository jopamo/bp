# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="https://wiki.linuxfoundation.org/networking/iproute2"
SNAPSHOT=d2a8ffe85ac64f91ee2aa7679a5046f321b54127
SRC_URI="https://github.com/iproute2/iproute2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/iproute2-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"
#build fails on musl

IUSE="caps elf iptables"

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

PATCHES=(
	"${FILESDIR}"/iproute2-5.7.0-mix-signal.h-include.patch
	"${FILESDIR}"/iproute2-mtu.patch
)

doecho() {
	echo "${@}"
	"${@}" || die
}

src_prepare() {
	filter-flags -Wl,-z,defs -flto*
	append-flags -ffat-lto-objects
	append-flags -D__UAPI_DEF_IN6_ADDR=0 -D__UAPI_DEF_IN6_ADDR_ALT=0 -D__UAPI_DEF_SOCKADDR_IN6=0 -D__UAPI_DEF_IPV6_MREQ=0

	use elibc_musl && eapply "${FILESDIR}"/iproute2-6.8.0-configure-nomagic-nolibbsd.patch
	use elibc_musl && eapply "${FILESDIR}"/iproute2-6.8.0-disable-libbsd-fallback.patch

	default

	# echo -n is not POSIX compliant
	sed 's@echo -n@printf@' -i configure || die

	sed -i \
		-e '/^CC :\?=/d' \
		-e "/^LIBDIR/s:=.*:=/lib:" \
		-e "s|-O2|${CFLAGS} ${CPPFLAGS}|" \
		-e "/^HOSTCC/s:=.*:= $(tc-getBUILD_CC):" \
		-e "/^DBM_INCLUDE/s:=.*:=${T}:" \
		Makefile || die

	sed -i 's:TCPI_OPT_ECN_SEEN:16:' misc/ss.c || die
}

src_configure() {
	tc-export AR CC PKG_CONFIG

	# This sure is ugly.  Should probably move into toolchain-funcs at some point.
	local setns
	pushd "${T}" >/dev/null
	printf '#include <sched.h>\nint main(){return setns(0, 0);}\n' > test.c
	${CC} ${CFLAGS} ${CPPFLAGS} -D_GNU_SOURCE ${LDFLAGS} test.c >&/dev/null && setns=y || setns=n
	echo 'int main(){return 0;}' > test.c
	${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} test.c -lresolv >&/dev/null || sed -i '/^LDLIBS/s:-lresolv::' "${S}"/Makefile
	popd >/dev/null

	doecho ./configure
}

src_compile() {
	emake V=1 NETNS_RUN_DIR=/run/netns
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
