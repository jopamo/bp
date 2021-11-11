# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="https://www.ruby-lang.org/"
SRC_URI="https://cache.ruby-lang.org/pub/ruby/$(ver_cut 1-2)/${P}.tar.gz"

LICENSE="|| ( Ruby-BSD BSD-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug jemalloc socks5 static-libs"

append-flags -fno-strict-aliasing
filter-flags -fomit-frame-pointer -Wl,-z,defs

src_prepare() {
	default
	einfo "Removing bundled libraries..."
	rm -fr ext/fiddle/libffi-3.2.1 || die
}

src_configure() {
	local myconf=(
		--enable-shared
		--enable-pthread
		--disable-rpath
		--with-out-ext="dbm tk"
		$(use_with jemalloc jemalloc)
		$(use_enable socks5 socks)
		--disable-install-doc
		--disable-ipv6
		$(use_enable static-libs static)
		$(use_enable static-libs install-static-library)
		$(use_with static-libs static-linked-ext)
		$(use_enable debug)
		--enable-option-checking=no
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
