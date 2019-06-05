# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 flag-o-matic

DESCRIPTION="Core binutils libraries (libbfd, libopcodes, libiberty) for external packages"
HOMEPAGE="https://sourceware.org/binutils/"

EGIT_REPO_URI="https://github.com/1g4-linux/binutils-gdb.git"
EGIT_BRANCH="binutils-$(ver_cut 1)_$(ver_cut 2)-branch"

SLOT="0"

LICENSE="|| ( GPL-3 LGPL-3 )"

KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-ld=default
		--disable-multilib
		--disable-obsolete
		--disable-werror
		$(usex static-libs '--disable-shared' '--enable-shared')
		--with-system-zlib
		--disable-gold
		--enable-install-libiberty
		--enable-deterministic-archives
		--disable-nls
		--enable-default-hash-style=gnu
		--enable-plugins
		--enable-lto
		--disable-{gdb,sim}
		--without-included-gettext
		$(use_enable static-libs static)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
