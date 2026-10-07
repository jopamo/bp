# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit flag-o-matic

DESCRIPTION="Functional, imperative, and object-oriented programming language"
HOMEPAGE="https://ocaml.org/"
SNAPSHOT=46e1c324fb9e9f21f52c9cc3399020f7ef8b9b91
SRC_URI="https://github.com/ocaml/ocaml/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
RESTRICT="test"

src_configure() {
	# Installed runtime archives must contain native code, not compiler-specific IR.
	filter-lto
	econf \
		--bindir="${EPREFIX}/usr/bin" \
		--libdir="${EPREFIX}/usr/lib/ocaml" \
		--mandir="${EPREFIX}/usr/share/man" \
		--prefix="${EPREFIX}/usr"
}

src_compile() {
	emake world
	emake opt
	emake opt.opt
}

src_install() {
	emake DESTDIR="${D}" install
}
