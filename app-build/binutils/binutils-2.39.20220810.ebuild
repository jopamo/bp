# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="a collection of binary tools"
HOMEPAGE="https://sourceware.org/binutils/"

SNAPSHOT=9e855cffa1fda44629e7f9b76dfa3e5a51a440e9
SRC_URI="https://git.linaro.org/toolchain/binutils-gdb.git/snapshot/binutils-gdb-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-gdb-${SNAPSHOT}

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
#KEYWORDS="amd64 arm64"

DEPEND="
	lib-core/zlib
	lib-core/elfutils
	virtual/libc
"

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--disable-gold
		--disable-multilib
		--disable-nls
		--disable-obsolete
		--disable-werror
		--disable-{gdb,sim}
		--enable-default-hash-style=gnu
		--enable-deterministic-archives
		--enable-install-libiberty
		--enable-ld=default
		--enable-lto
		--enable-plugins
		--enable-relro
		--enable-threads
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
