# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=c097e42daaba358995cd89317daed612aaae2617

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Lists open files for running Unix processes"
HOMEPAGE="ftp://lsof.itap.purdue.edu/pub/tools/unix/lsof/"
SRC_URI="https://github.com/lsof-org/lsof/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="lsof"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 rpc static"

RDEPEND="rpc? ( lib-net/libtirpc )"

DEPEND="${RDEPEND}
	rpc? ( dev-util/pkgconf )"

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

src_configure() {
	use static && append-ldflags -static

	append-cppflags $(use rpc && $(tc-getPKG_CONFIG) libtirpc --cflags || echo "-DHASNOTRPC -DHASNORPC_H")
	append-cppflags $(usex ipv6 -{D,U}HASIPv6)

	export LSOF_CFGL="${CFLAGS} ${LDFLAGS} \
		$(use rpc && $(tc-getPKG_CONFIG) libtirpc --libs)"

	# Set LSOF_INCLUDE to a dummy location so the script doesn't poke
	# around in it and mix /usr/include paths with cross-compile/etc.
	touch .neverInv
	LSOF_INCLUDE=${T} \
	LSOF_CC=$(tc-getCC) \
	LSOF_AR="$(tc-getAR) rc" \
	LSOF_RANLIB=$(tc-getRANLIB) \
	LSOF_CFGF="${CFLAGS} ${CPPFLAGS}" \
	./Configure -n linux || die
}

src_compile() {
	emake DEBUG="" all
}

src_install() {
	dobin lsof
}
