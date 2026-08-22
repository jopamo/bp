# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Program matching and transformation engine for C code"
HOMEPAGE="https://coccinelle.gitlabpages.inria.fr/website/ https://github.com/coccinelle/coccinelle"
SNAPSHOT=ab0c6c4900a981db7bca4e1323408dd46cdf56a2
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
	app-lang/findlib
	app-lang/ocaml
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
