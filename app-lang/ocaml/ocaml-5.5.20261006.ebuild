# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

inherit flag-o-matic

DESCRIPTION="Functional, imperative, and object-oriented programming language"
HOMEPAGE="https://ocaml.org/"
SNAPSHOT=9dcf0c86201cf5e8ece56c6bb5f61fc4d92fb74a
SRC_URI="https://github.com/ocaml/ocaml/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
RESTRICT="test"

PATCHES=( "${FILESDIR}/${PN}-5.5-bigarray-dimension-bounds.patch" )

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
