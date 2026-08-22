# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Program matching and transformation engine for C code"
HOMEPAGE="https://coccinelle.gitlabpages.inria.fr/website/ https://github.com/coccinelle/coccinelle"
SNAPSHOT=03a1af0a3316ddfc2b54d827b8b9627a841c85c9
SRC_URI="https://github.com/coccinelle/coccinelle/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

BDEPEND="
	app-build/autoconf
	app-build/automake
	app-dev/pkgconf
	app-lang/ocaml
	dev-ml/findlib
"

src_prepare() {
	default
	./autogen || die
}

src_configure() {
	econf \
		--disable-ocaml \
		--disable-pcre-syntax \
		--disable-python \
		--without-bash-completion \
		--without-metainfo
}

src_compile() {
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install
}
