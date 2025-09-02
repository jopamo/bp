# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="binutils-$(ver_cut 1)_$(ver_cut 2)-branch"

inherit flag-o-matic

DESCRIPTION="a collection of binary tools"
HOMEPAGE="https://sourceware.org/binutils/"
SNAPSHOT=342f3e97184919a512b02a8c8623b47200f91725
SRC_URI="https://github.com/1g4-mirror/binutils-gdb/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/binutils-gdb-${SNAPSHOT}"

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gprof gprofng"

DEPEND="
	lib-core/zlib
	lib-core/elfutils
	virtual/libc
"

PATCHES=( "${FILESDIR}"/binutils-ld-fix-static-linking.patch )

src_configure() {
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"
	filter-flags -Wl,defs
	append-flags -ffat-lto-objects

	local myconf=(
		--disable-gdb
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
		--with-system-zlib
		--without-included-gettext
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	rm -f "${ED}"/usr/bin/gdbserver "${ED}"/usr/lib/libinproctrace.so || die

	# No shared linking to these files outside binutils
	rm -f "${ED}"/usr/lib/lib{bfd,opcodes}.so || die
	echo 'INPUT( /usr/lib/libbfd.a -liberty -lz -ldl )' > "${ED}"/usr/lib/libbfd.so
	echo 'INPUT( /usr/lib/libopcodes.a -lbfd )' > "${ED}"/usr/lib/libopcodes.so

	for x in ld objdump readelf ranlib objcopy nm as strip ld.bfd ar ; do
		dosym -r /usr/bin/${x} /usr/bin/${CHOST}-${x}
	done
}
