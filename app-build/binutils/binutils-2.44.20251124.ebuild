# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="binutils-$(ver_cut 1)_$(ver_cut 2)-branch"

inherit flag-o-matic qa-policy

DESCRIPTION="a collection of binary tools"
HOMEPAGE="https://sourceware.org/binutils/"
SNAPSHOT=9256a4b356856649ec1e3e4dd9371ce29603cfda
SRC_URI="https://github.com/1g4-mirror/binutils-gdb/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/binutils-gdb-${SNAPSHOT}"

LICENSE="GPL-2+ GPL-3+ LGPL-2+ LGPL-2.1+ BSD BSD-with-attribution public-domain FDL-1.3"
SLOT="0"
KEYWORDS="amd64 arm64"

COMMON_DEPEND="
	lib-core/zlib
	app-compression/zstd
	lib-core/elfutils
	virtual/libc
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

PATCHES=(
	"${FILESDIR}"/binutils-ld-fix-static-linking.patch
	#"${FILESDIR}"/binutils-flex-2.6-yyatbol.patch
)

src_configure() {
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"

	filter-flags -Wl,defs
	append-flags -ffat-lto-objects

	local QA_POLICY_LTO_FLAVOR=fat+strip
	qa-policy-configure

	local myconf=(
		--disable-gdb
		--disable-gdbserver
		--disable-gold
		--disable-gprofng
		--disable-multilib
		--disable-nls
		--disable-obsolete
		--disable-sim
		--disable-werror
		--enable-64-bit-bfd
		--enable-colored-disassembly
		--enable-default-execstack=no
		--enable-default-hash-style=gnu
		--enable-deterministic-archives
		--enable-ld=default
		--enable-lto
		--enable-new-dtags
		--enable-relro
		--enable-threads
		--prefix="${EPREFIX}"/usr
		--with-mmap
		--with-pic
		--with-system-readline
		--with-system-zlib
		--without-included-gettext
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	# libbfd consumers in this tree link via -liberty through libbfd.so
	# linker script, so install the built libiberty archive alongside libbfd.
	insinto /usr/lib
	doins libiberty/libiberty.a

	# libtool archives are not shipped for this package in the tree.
	find "${ED}"/usr/lib -type f -name '*.la' -delete || die

	# No shared linking to these files outside binutils
	rm -f "${ED}"/usr/lib/lib{bfd,opcodes}.so || die
	cat > "${ED}"/usr/lib/libbfd.so <<-'EOF' || die
/* GNU ld script */
INPUT ( /usr/lib/libbfd.a -liberty -lsframe -lz -lzstd -lstdc++ -ldl )
EOF
	cat > "${ED}"/usr/lib/libopcodes.so <<-'EOF' || die
/* GNU ld script */
INPUT ( /usr/lib/libopcodes.a -lbfd )
EOF

	for x in ld objdump readelf ranlib objcopy nm as strip ld.bfd ar ; do
		dosym -r /usr/bin/${x} /usr/bin/${CHOST}-${x}
	done

	qa-policy-install
}
