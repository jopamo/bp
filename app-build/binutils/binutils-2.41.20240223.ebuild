# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="a collection of binary tools"
HOMEPAGE="https://sourceware.org/binutils/"

SNAPSHOT=1900793bab0f8febb2566293ea932708d89b82e7
SRC_URI="https://github.com/bminor/binutils-gdb/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
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

src_configure() {
	filter-flags -Wl,defs

	local myconf=(
		$(use_enable gprof)
		$(use_enable gprofng)
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
		--prefix="${EPREFIX}"/usr
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
