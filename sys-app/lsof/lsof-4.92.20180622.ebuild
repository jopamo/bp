# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils flag-o-matic toolchain-funcs

MY_P=${P/-/_}
DESCRIPTION="Lists open files for running Unix processes"
HOMEPAGE="ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/"

SNAPSHOT=cb49fe80ad9e3afe540b09286325bc7c48b39b54
SRC_URI="https://github.com/lsof-org/lsof-linux/archive/${SNAPSHOT}.zip -> ${P}.zip"
S=${WORKDIR}/${PN}-linux-${SNAPSHOT}

LICENSE="lsof"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="examples ipv6 rpc selinux static"

RDEPEND="rpc? ( lib-net/libtirpc )
	selinux? ( lib-sys/libselinux )"
DEPEND="${RDEPEND}
	rpc? ( dev-util/pkgconfig )"

PATCHES=(
		"${FILESDIR}"/${PN}-4.85-cross.patch #432120
		)

src_prepare() {
	sed -i \
		-e 's:echo -n:printf:' \
		AFSConfig Configure Customize Inventory tests/CkTestDB || die
	# convert `test -r header.h` into a compile test
	sed -i -r \
		-e 's:test -r \$\{LSOF_INCLUDE\}/([[:alnum:]/._]*):echo "#include <\1>" | ${LSOF_CC} ${LSOF_CFGF} -E - >/dev/null 2>\&1:' \
		-e 's:grep (.*) \$\{LSOF_INCLUDE\}/([[:alnum:]/._]*):echo "#include <\2>" | ${LSOF_CC} ${LSOF_CFGF} -E -P -dD - 2>/dev/null | grep \1:' \
		Configure || die

	default
}

target() {
	case ${CHOST} in
	*-darwin*)  echo darwin  ;;
	*-freebsd*) echo freebsd ;;
	*-solaris*) echo solaris ;;
	*-aix*)     echo aixgcc  ;;
	*)          echo linux   ;;
	esac
}

src_configure() {
	use static && append-ldflags -static

	append-cppflags $(use rpc && $(tc-getPKG_CONFIG) libtirpc --cflags || echo "-DHASNOTRPC -DHASNORPC_H")
	append-cppflags $(usex ipv6 -{D,U}HASIPv6)

	export LSOF_CFGL="${CFLAGS} ${LDFLAGS} \
		$(use rpc && $(tc-getPKG_CONFIG) libtirpc --libs)"

	# Set LSOF_INCLUDE to a dummy location so the script doesn't poke
	# around in it and mix /usr/include paths with cross-compile/etc.
	touch .neverInv
	LINUX_HASSELINUX=$(usex selinux y n) \
	LSOF_INCLUDE=${T} \
	LSOF_CC=$(tc-getCC) \
	LSOF_AR="$(tc-getAR) rc" \
	LSOF_RANLIB=$(tc-getRANLIB) \
	LSOF_CFGF="${CFLAGS} ${CPPFLAGS}" \
	./Configure -n $(target) || die
}

src_compile() {
	emake DEBUG="" all
}

src_install() {
	dobin lsof
}
