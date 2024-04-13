# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Command-line utility and library for lossy compression of PNG images"
HOMEPAGE="https://pngquant.org/ https://github.com/kornelski/pngquant"
SRC_URI="https://github.com/kornelski/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 HPND rwpng"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cpu_flags_x86_sse2 debug lcms openmp test"
REQUIRED_USE="test? ( lcms )"

RDEPEND="
	xmedia-lib/libpng
	xmedia-lib/libimagequant:=
	lib-core/zlib
	lcms? ( xgui-misc/lcms )
"
DEPEND="${RDEPEND}"
BDEPEND="app-dev/pkgconf"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/${PN}-2.12.2-respect-CFLAGS.patch
	"${FILESDIR}"/${PN}-2.17.0-fix-test-version.patch
)

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

src_prepare() {
	default

	# avoid silent fallback to bundled lib
	rm -rv lib || die
}

src_configure() {
	tc-export AR CC

	./configure \
		--prefix="${EPREFIX}/usr" \
		--with-libimagequant \
		$(use debug && echo --enable-debug) \
		$(use openmp && echo --with-openmp) \
		$(use_with lcms lcms2) \
		CFLAGS="${CFLAGS} ${CPPFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc CHANGELOG README.md
}
