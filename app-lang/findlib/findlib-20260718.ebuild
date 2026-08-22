# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="OCaml tool to find and use non-standard packages"
HOMEPAGE="https://projects.camlcity.org/projects/findlib.html https://github.com/ocaml/ocamlfind"
SNAPSHOT=be2335f14cc45b5551dea4278affdfb2718eb72e
SRC_URI="https://github.com/ocaml/ocamlfind/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ocamlfind-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

BDEPEND="app-lang/ocaml"
RDEPEND="${BDEPEND}"

src_prepare() {
	default

	sed -i \
		-e '/dbm/d' \
		-e '/graphics/d' \
		-e '/ocamlbuild/d' \
		-e '/check_library num/d' \
		configure || die
	sed -i 's|Pervasives\.||g' src/findlib-toolbox/make_wizard.ml || die
}

src_configure() {
	./configure \
		-bindir "${EPREFIX}/usr/bin" \
		-mandir "${EPREFIX}/usr/share/man" \
		-sitelib "${EPREFIX}/usr/lib/ocaml" \
		-config "${EPREFIX}/usr/lib/ocaml/findlib.conf" \
		-no-custom || die
}

src_compile() {
	emake -j1 all
	emake -j1 opt
}

src_install() {
	emake prefix="${D}" install
}
