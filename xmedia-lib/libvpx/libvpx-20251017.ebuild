# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="WebM VP8 and VP9 Codec SDK"
HOMEPAGE="https://www.webmproject.org"
SNAPSHOT=84a3c9dee9ef7f7b8433d6f7019c19ac7c4fddb2
SRC_URI="https://github.com/webmproject/libvpx/archive/${SNAPSHOT}.tar.gz -> libvpx-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libvpx-${SNAPSHOT}"

EGIT_BRANCH="pekin"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

DEPEND="app-lang/nasm"

src_configure() {
	local conf=(
		--prefix="${EPREFIX}"/usr
		--libdir="${EPREFIX}"/usr/lib
		$(use_enable static-libs static)
		$(use_enable test unit-tests)
		--enable-multithread
		--enable-vp9-highbitdepth
		--disable-examples
		--disable-docs
		--disable-install-docs
		--disable-install-srcs
		--enable-pic
		--enable-postproc
		--enable-runtime-cpu-detect
		--enable-shared
		--enable-vp8
		--enable-vp9
		--enable-vp9-highbitdepth
		--enable-vp9-temporal-denoising
	)

	"${S}"/configure "${conf[@]}"
}

src_compile() {
	emake verbose=yes GEN_EXAMPLES=""
}

src_install() {
	emake verbose=yes GEN_EXAMPLES="" DESTDIR="${D}" install
}
