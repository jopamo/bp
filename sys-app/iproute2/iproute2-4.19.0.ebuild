# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs flag-o-matic

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iproute2.git"
	inherit git-r3
else
	SRC_URI="mirror://kernel/linux/utils/net/${PN}/${P}.tar.xz"
	KEYWORDS="amd64 arm64"
fi

DESCRIPTION="kernel routing and traffic control utilities"
HOMEPAGE="https://wiki.linuxfoundation.org/networking/iproute2"

LICENSE="GPL-2"
SLOT="0"
IUSE="atm elf ipv6 minimal"

RDEPEND="
	!minimal? ( lib-net/libmnl )
	elf? ( virtual/libelf )
	atm? ( net-dialup/linux-atm )
"

DEPEND="
	${RDEPEND}
	app-compression/xz-utils
	>=sys-devel/bison-2.4
	sys-devel/flex
	>=sys-kernel/stable-sources-3.16
	elibc_glibc? ( >=lib-sys/glibc-2.7 )
"

src_prepare() {
	if ! use ipv6 ; then
		PATCHES+=(
			"${FILESDIR}"/${PN}-4.11.0-no-ipv6.patch #326849
		)
	fi

	default

	sed -i \
		-e '/^CC :\?=/d' \
		-e "/^LIBDIR/s:=.*:=/lib64:" \
		-e "s:-O2:${CFLAGS} ${CPPFLAGS}:" \
		-e "/^HOSTCC/s:=.*:= $(tc-getBUILD_CC):" \
		-e "/^WFLAGS/s:-Werror::" \
		-e "/^DBM_INCLUDE/s:=.*:=${T}:" \
		Makefile || die

	# Use /run instead of /var/run.
	sed -i \
		-e 's:/var/run:/run:g' \
		include/namespace.h \
		man/man8/ip-netns.8 || die

	# build against system headers
	rm -r include/netinet #include/linux include/ip{,6}tables{,_common}.h include/libiptc
	sed -i 's:TCPI_OPT_ECN_SEEN:16:' misc/ss.c || die

	use minimal && sed -i -e '/^SUBDIRS=/s:=.*:=lib tc ip:' Makefile
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
	econf

	# ...now switch on/off requested features via USE flags
	# this is only useful if the test did not set other things, per bug #643722
	cat <<-EOF >> config.mk
	TC_CONFIG_ATM := $(usex atm y n)
	# We've locked in recent enough kernel headers #549948
	TC_CONFIG_IPSET := y
	HAVE_BERKELEY_DB := n
	HAVE_MNL      := $(usex minimal n y)
	HAVE_ELF      := $(usex elf y n)
	IP_CONFIG_SETNS := ${setns}
	EOF
}

src_compile() {
	emake V=1
}

src_install() {
	if use minimal ; then
		into /
		dosbin tc/tc
		dobin ip/ip
		return 0
	fi

	emake \
		DESTDIR="${D}" \
		LIBDIR="${EPREFIX}"/usr/lib64 \
		SBINDIR="${EPREFIX}"/usr/sbin		\
		CONFDIR="${EPREFIX}"/etc/iproute2 \
		DOCDIR="${EPREFIX}"/usr/share/doc/${PF} \
		MANDIR="${EPREFIX}"/usr/share/man \
		ARPDDIR="${EPREFIX}"/var/lib/arpd \
		install

	dodir /usr/bin
	mv "${ED%/}"/usr/{s,}bin/ip || die #330115

	dolib.a lib/libnetlink.a
	insinto /usr/include
	doins include/libnetlink.h
	find "${ED}" -type d -empty -delete
	sed -i '/linux\/netconf.h/d' "${ED%/}"/usr/include/libnetlink.h || die
}
