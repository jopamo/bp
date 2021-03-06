# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools git-r3

DESCRIPTION="HTTP/2 C Library"
HOMEPAGE="https://nghttp2.org/"
EGIT_REPO_URI="https://github.com/nghttp2/nghttp2.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cxx debug hpack-tools jemalloc static-libs test utils xml"

RDEPEND="
	cxx? ( lib-dev/boost )
	hpack-tools? ( >=lib-core/jansson-2.5 )
	jemalloc? ( lib-dev/jemalloc )
	utils? (
		>=lib-dev/libev-4.15
		virtual/ssl
		>=lib-core/zlib-1.2.3
		lib-net/c-ares:=
	)
	xml? ( >=lib-core/libxml2-2.7.7:2 )"
DEPEND="${RDEPEND}
	app-dev/pkgconf
	test? ( >=app-dev/cunit-2.1 )"

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-examples
		--disable-failmalloc
		--disable-werror
		--without-cython
		--disable-python-bindings
		$(use_enable cxx asio-lib)
		$(use_enable debug)
		$(use_enable hpack-tools)
		$(use_enable static-libs static)
		$(use_enable utils app)
		$(use_with jemalloc)
		$(use_with xml libxml2)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
