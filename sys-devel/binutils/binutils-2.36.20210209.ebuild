# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Core binutils libraries (libbfd, libopcodes, libiberty) for external packages"
HOMEPAGE="https://sourceware.org/binutils/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/bminor/binutils-gdb.git"
	inherit git-r3
	EGIT_BRANCH="binutils-$(ver_cut 1)_$(ver_cut 2)-branch"
else
	SNAPSHOT=7651a4871c225925ffdfda0a8c91a6ed370cd9a1
	SRC_URI="https://github.com/bminor/binutils-gdb/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-gdb-${SNAPSHOT}
fi

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-sys/zlib
	lib-dev/elfutils
	lib-sys/glibc
"

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--enable-ld=default
		--disable-multilib
		--disable-obsolete
		--disable-werror
		--with-system-zlib
		--enable-gold
		--enable-install-libiberty
		--enable-deterministic-archives
		--enable-relro
		--disable-nls
		--enable-default-hash-style=gnu
		--enable-plugins
		--enable-lto
		--enable-threads
		--disable-{gdb,sim}
		--without-included-gettext
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	rm "${ED}"/usr/bin/gdbserver "${ED}"/usr/lib/libinproctrace.so

	# No shared linking to these files outside binutils
	rm -f "${ED}"/usr/lib/lib{bfd,opcodes}.so
	echo 'INPUT( /usr/lib/libbfd.a -liberty -lz -ldl )' > "${ED}"/usr/lib/libbfd.so
	echo 'INPUT( /usr/lib/libopcodes.a -lbfd )' > "${ED}"/usr/lib/libopcodes.so
}
