# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Program matching and transformation engine for C code"
HOMEPAGE="https://coccinelle.gitlabpages.inria.fr/website/ https://github.com/coccinelle/coccinelle"
SNAPSHOT=11b93adb6516a358a6687051e5762136666626e0
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
	>=app-lang/findlib-20260718-r1
	>=app-lang/ocaml-5.5:0=
	<app-lang/ocaml-5.6:0
"

PATCHES=(
	"${FILESDIR}/${PN}-stdcompat-ocaml-5.4.patch"
	"${FILESDIR}/${PN}-stdcompat-ocaml-5.5.patch"
)

src_prepare() {
	default
	./autogen || die
	(
		cd bundles/stdcompat/stdcompat-current || die
		eautoconf
	)
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
