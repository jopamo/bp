# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="https://wiki.linuxfoundation.org/networking/iproute2"

SNAPSHOT=0ea0699ea01df81750becf742083933a23a95d94
SRC_URI="https://github.com/iproute2/iproute2/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps elf iptables musl"

DEPEND="
	app-build/bison
	app-build/flex
	app-compression/xz-utils
	app-kernel/linux-headers
	lib-net/libmnl
	caps? ( lib-core/libcap )
	elf? ( lib-core/elfutils )
	iptables? ( app-net/iptables )
	!musl? ( lib-dev/libbsd )
"

PATCHES=(
	"${FILESDIR}"/${PN}-5.7.0-mix-signal.h-include.patch
	"${FILESDIR}"/${PN}-mtu.patch
)

doecho() {
	echo "${@}"
	"${@}" || die
}

src_prepare() {
	filter-flags -Wl,-z,defs

	use musl && eapply "${FILESDIR}"/${PN}-6.8.0-configure-nomagic-nolibbsd.patch
	use musl && eapply "${FILESDIR}"/${PN}-6.8.0-disable-libbsd-fallback.patch

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

	# build against system headers
	rm -r include/netinet || die #include/linux include/ip{,6}tables{,_common}.h include/libiptc
	rm -r include/uapi/linux/{in6.h,if_bridge.h} || die
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

	# run "configure" script first which will create "config.mk"...
	# Using econf breaks since 5.14.0 (a9c3d70d902a0473ee5c13336317006a52ce8242)
	doecho ./configure

	# ...now switch on/off requested features via USE flags
	# this is only useful if the test did not set other things, per bug #643722
	cat <<-EOF >> config.mk
	TC_CONFIG_ATM := n
	TC_CONFIG_XT  := $(usex iptables y n)
	TC_CONFIG_NO_XT := $(usex iptables n y)
	TC_CONFIG_IPSET := y
	HAVE_BERKELEY_DB := n
	HAVE_CAP      := $(usex caps y n)
	HAVE_MNL      := n
	HAVE_ELF      := $(usex elf y n)
	HAVE_SELINUX  := n
	IP_CONFIG_SETNS := ${setns}
	# Use correct iptables dir, #144265 #293709
	IPT_LIB_DIR   := $(use iptables && ${PKG_CONFIG} xtables --variable=xtlibdir)
	HAVE_LIBBSD   := n
	EOF
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
		SBINDIR="${EPREFIX}"/usr/sbin \
		CONFDIR="${EPREFIX}"/etc/iproute2 \
		DOCDIR="${EPREFIX}"/usr/share/doc/${PF} \
		MANDIR="${EPREFIX}"/usr/share/man \
		ARPDDIR="${EPREFIX}"/var/lib/arpd \
		install

	if [[ -d "${ED}"/var/lib/arpd ]]; then
		rmdir --ignore-fail-on-non-empty -p "${ED}"/var/lib/arpd || die
	fi
}
