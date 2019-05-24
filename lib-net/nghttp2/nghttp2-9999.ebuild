# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/nghttp2/nghttp2.git"
	inherit autotools git-r3
else
	SRC_URI="https://github.com/nghttp2/nghttp2/releases/download/v${PV}/${P}.tar.xz"
fi

DESCRIPTION="HTTP/2 C Library"
HOMEPAGE="https://nghttp2.org/"
KEYWORDS="amd64 arm64"

LICENSE="MIT"
SLOT="0/1.14" # <C++>.<C> SONAMEs
IUSE="cxx debug hpack-tools jemalloc static-libs test utils xml"

RDEPEND="
	cxx? ( lib-dev/boost:=[threads] )
	hpack-tools? ( >=lib-dev/jansson-2.5 )
	jemalloc? ( lib-dev/jemalloc )
	utils? (
		>=lib-dev/libev-4.15
		>=lib-dev/openssl-1.0.2:0[-bindist]
		>=lib-sys/zlib-1.2.3
		lib-net/c-ares:=
	)
	xml? ( >=lib-dev/libxml2-2.7.7:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconf
	test? ( >=dev-util/cunit-2.1 )"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	local myeconfargs=(
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
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_install() {
	default
	use static-libs || find "${ED%/}"/usr -name '*.la' -delete
}
