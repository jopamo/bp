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

src_prepare() {
	default

	append-flags -fno-strict-aliasing
	filter-flags -fomit-frame-pointer -Wl,-z,defs
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable socks5 socks)
		$(use_enable static-libs install-static-library)
		$(use_enable static-libs static)
		$(use_with jemalloc jemalloc)
		$(use_with static-libs static-linked-ext)
		--disable-install-doc
		--disable-ipv6
		--disable-rpath
		--enable-option-checking=no
		--enable-pthread
		--enable-shared
		--with-out-ext="dbm tk"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
