# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Core binutils libraries (libbfd, libopcodes, libiberty) for external packages"
HOMEPAGE="https://sourceware.org/binutils/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/binutils-gdb.git"
	inherit git-r3
	EGIT_BRANCH="binutils-$(ver_cut 1)_$(ver_cut 2)-branch"
else
	SNAPSHOT=b54c2337de6521b453b86dc428d099651a75a09c
	SRC_URI="https://github.com/1g4-mirror/binutils-gdb/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-gdb-${SNAPSHOT}
fi

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-ld=default
		--disable-multilib
		--disable-obsolete
		--disable-werror
		$(usex static-libs '--disable-shared' '--enable-shared')
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
		$(use_enable static-libs static)
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
