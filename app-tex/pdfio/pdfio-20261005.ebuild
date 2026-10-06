# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="v1.6.x"

inherit autotools flag-o-matic toolchain-funcs qa-policy

DESCRIPTION="C library for reading and writing PDF files"
HOMEPAGE="https://www.msweet.org/pdfio/"
SNAPSHOT=78c3646a252bd5a953e0198b12155feb6aea076c
SRC_URI="https://github.com/michaelrsweet/pdfio/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-core/zlib
	xmedia-lib/libpng
"
DEPEND="${RDEPEND}"
BDEPEND="app-dev/pkgconf"

src_prepare() {
	default
	sed -i 's/libpng16/libpng/g' configure.ac || die
	eautoconf
}

src_configure() {
	qa-policy-configure
	tc-export CC AR RANLIB
	append-cflags -fPIC

	econf \
		--enable-shared \
		--disable-static \
		--enable-libpng \
		--with-dsoflags="${LDFLAGS}"
}

src_compile() {
	emake OPTIM=""
}

src_test() {
	emake OPTIM="" test
}

src_install() {
	dolib.so libpdfio.so.1
	dosym libpdfio.so.1 "/usr/$(get_libdir)/libpdfio.so"
	doheader pdfio.h pdfio-content.h
	insinto "/usr/$(get_libdir)/pkgconfig"
	doins pdfio.pc
	doman doc/pdfio.3

	qa-policy-install
}
