# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Functional, imperative, and object-oriented programming language"
HOMEPAGE="https://ocaml.org/"
SNAPSHOT=c6daf5d6ef3dc536de229fffabf82bd33fb0308d
SRC_URI="https://github.com/ocaml/ocaml/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

src_configure() {
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
