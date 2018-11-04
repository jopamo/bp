# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs multilib-minimal git-r3

DESCRIPTION="WebM VP8 and VP9 Codec SDK"
HOMEPAGE="https://www.webmproject.org"
EGIT_REPO_URI="https://github.com/webmproject/libvpx.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs test"

DEPEND="dev-lang/yasm"

multilib_src_configure() {
	local conf=(
		--prefix="${EPREFIX}"/usr
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--enable-pic
		--enable-vp8
		--enable-vp9
		--enable-shared
		--extra-cflags="${CFLAGS}"
		$(use_enable static-libs static)
		$(use_enable test unit-tests)
		--enable-multithread
		--enable-vp9-highbitdepth
		--disable-examples
		--disable-install-docs
		--disable-docs
	)

	"${S}"/configure "${conf[@]}"
}

multilib_src_compile() {
	emake verbose=yes GEN_EXAMPLES=""
}

multilib_src_install() {
	emake verbose=yes GEN_EXAMPLES="" DESTDIR="${D}" install
}
