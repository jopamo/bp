# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=25f88a5677e317e279ae10435b9adf125b0f91d1
EGIT_REPO_URI="https://gitlab.inria.fr/coccinelle/coccinelle.git"
EGIT_COMMIT="${SNAPSHOT}"

PYTHON_COMPAT=( python3_{13,14} )

inherit autotools git-snapshot python-single-r1

DESCRIPTION="Program matching and transformation engine for C code"
HOMEPAGE="https://coccinelle.gitlabpages.inria.fr/website/ https://github.com/coccinelle/coccinelle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	lib-core/libpcre2
"
RDEPEND="
	${DEPEND}
	>=app-lang/findlib-20260718-r1
	>=app-lang/ocaml-5.5:0=
	<app-lang/ocaml-5.6:0
	app-core/bx
"
BDEPEND+="
	${PYTHON_DEPS}
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
	python_fix_shebang tools/pycocci
	./autogen || die
	(
		cd bundles/stdcompat/stdcompat-current || die
		eautoconf
	)
}

src_configure() {
	econf \
		--enable-ocaml \
		--enable-pcre-syntax \
		--enable-python \
		--with-python="${PYTHON}" \
		--without-bash-completion \
		--without-metainfo

	local feature
	for feature in OCAML PYTHON pcre; do
		grep -qx "FEATURE_${feature}=1" Makefile.config ||
			die "${feature} support was not enabled"
	done
}

src_compile() {
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install
	dobin tools/pycocci
}
