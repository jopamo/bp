# Distributed under the terms of the GNU General Public License v2

# TODO: Add python support.

EAPI=6

inherit multilib-minimal

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
IUSE="cxx debug hpack-tools jemalloc libressl static-libs test +threads utils xml"

RDEPEND="
	cxx? ( lib-dev/boost:=[${MULTILIB_USEDEP},threads] )
	hpack-tools? ( >=lib-dev/jansson-2.5 )
	jemalloc? ( lib-dev/jemalloc[${MULTILIB_USEDEP}] )
	utils? (
		>=lib-dev/libev-4.15[${MULTILIB_USEDEP}]
		!libressl? ( >=lib-dev/openssl-1.0.2:0[-bindist,${MULTILIB_USEDEP}] )
		libressl? ( lib-dev/libressl[${MULTILIB_USEDEP}] )
		>=lib-sys/zlib-1.2.3[${MULTILIB_USEDEP}]
		lib-net/c-ares:=[${MULTILIB_USEDEP}]
	)
	xml? ( >=lib-dev/libxml2-2.7.7:2[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( >=dev-util/cunit-2.1[${MULTILIB_USEDEP}] )"

src_prepare() {
	default
	[[ ${PV} == 9999 ]] && eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
		--disable-examples
		--disable-failmalloc
		--disable-werror
		--without-cython
		--disable-python-bindings
		$(use_enable cxx asio-lib)
		$(use_enable debug)
		$(multilib_native_use_enable hpack-tools)
		$(use_enable static-libs static)
		$(use_enable threads)
		$(multilib_native_use_enable utils app)
		$(multilib_native_use_with jemalloc)
		$(multilib_native_use_with xml libxml2)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_install_all() {
	use static-libs || find "${ED%/}"/usr -name '*.la' -delete
}
