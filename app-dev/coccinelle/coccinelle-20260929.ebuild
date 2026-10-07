# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=25f88a5677e317e279ae10435b9adf125b0f91d1
EGIT_REPO_URI="https://gitlab.inria.fr/coccinelle/coccinelle.git"
EGIT_COMMIT="${SNAPSHOT}"

inherit autotools git-snapshot

DESCRIPTION="Program matching and transformation engine for C code"
HOMEPAGE="https://coccinelle.gitlabpages.inria.fr/website/ https://github.com/coccinelle/coccinelle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

BDEPEND+="
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
