# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3

DESCRIPTION="Core binutils libraries (libbfd, libopcodes, libiberty) for external packages"
HOMEPAGE="https://sourceware.org/binutils/"

EGIT_REPO_URI="git://sourceware.org/git/binutils-gdb.git"
EGIT_BRANCH="binutils-2_32-branch"

SLOT="0"

LICENSE="|| ( GPL-3 LGPL-3 )"

KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-ld=default
		--disable-multilib
		--disable-obsolete
		--disable-werror
		--enable-shared
		--with-system-zlib
		--enable-gold
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

src_install() {
	default
	rm -rf "${ED}"/usr/bin/ld
	dosym /usr/bin/ld.gold /usr/bin/ld
}
