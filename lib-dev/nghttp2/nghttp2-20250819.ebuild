# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="HTTP/2 C Library"
HOMEPAGE="https://nghttp2.org/"
SNAPSHOT=56d5406bcee92e2528d8b632cbd6cb6cf9569e4e
SRC_URI="https://github.com/nghttp2/nghttp2/archive/${SNAPSHOT}.tar.gz -> nghttp2-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/nghttp2-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug hpack-tools jemalloc static-libs test utils xml"

RDEPEND="
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

src_prepare() {
	filter-flags -Wl,-z,defs

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable hpack-tools)
		$(use_enable static-libs static)
		$(use_enable utils app)
		$(use_with jemalloc)
		$(use_with xml libxml2)
		--disable-examples
		--disable-failmalloc
		--disable-werror
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
