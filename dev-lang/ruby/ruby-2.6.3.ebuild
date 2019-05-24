# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

SLOT=0/1

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="https://www.ruby-lang.org/"
SRC_URI=https://cache.ruby-lang.org/pub/ruby/2.6/${P}.tar.gz

LICENSE="|| ( Ruby-BSD BSD-2 )"
KEYWORDS="amd64 arm64"
IUSE="debug doc jemalloc socks5 static-libs"

filter-flags -fomit-frame-pointer
append-flags -fno-strict-aliasing
filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	einfo "Removing bundled libraries..."
	rm -fr ext/fiddle/libffi-3.2.1 || die
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--docdir=${EPREFIX}/usr/share/doc/${P} \
		--enable-shared
		--enable-pthread
		--disable-rpath
		--with-out-ext="dbm tk"
		$(use_with jemalloc jemalloc)
		$(use_enable socks5 socks)
		$(use_enable doc install-doc)
		--disable-ipv6
		$(use_enable static-libs static)
		$(use_enable static-libs install-static-library)
		$(use_with static-libs static-linked-ext)
		$(use_enable debug)
		--enable-option-checking=no
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
