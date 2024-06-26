# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A Library for Large Linear Classification"
HOMEPAGE="http://www.csie.ntu.edu.tw/~cjlin/liblinear/ https://github.com/cjlin1/liblinear"
SRC_URI="https://github.com/cjlin1/liblinear/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
SONAME="5"
KEYWORDS="amd64 arm64"

src_prepare() {
	default

	sed -i \
		-e '/^CFLAGS/d;/^CXXFLAGS/d' \
		blas/Makefile || die
	sed -i \
		-e 's|make|$(MAKE)|g' \
		-e '/$(LIBS)/s|$(CFLAGS)|& $(LDFLAGS)|g' \
		-e '/^CFLAGS/d;/^CXXFLAGS/d' \
		-e 's|$${SHARED_LIB_FLAG}|& $(LDFLAGS)|g' \
		Makefile || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS} -fPIC" \
		CXXFLAGS="${CXXFLAGS} -fPIC" \
		AR="$(tc-getAR)" \
		RANLIB="$(tc-getRANLIB)" \
		lib all
}

src_install() {
	dolib.so ${PN}.so.${SONAME}
	dosym ${PN}.so.${SONAME} /usr/lib/${PN}.so

	newbin predict ${PN}-predict
	newbin train ${PN}-train

	doheader linear.h
}
