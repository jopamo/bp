# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME=main
SNAPSHOT=29b8400ddc6cafcbb58988acbb77e7a7ea47e735

DESCRIPTION="Text based document generation using Python"
HOMEPAGE="https://asciidoc3.org/ https://gitlab.com/asciidoc3/asciidoc3/-/tree/${BRANCH_NAME}"
SRC_URI="https://gitlab.com/asciidoc3/asciidoc3/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=app-lang/python-3.10"

src_install() {
	insinto /usr/share/${PN}
	doins src/asciidoc3.conf
	doins src/asciidoc3api.py
	doins src/asciidoc3_toc_generator.py
	doins -r src/conf src/filters src/images

	exeinto /usr/share/${PN}
	doexe src/asciidoc3.py src/a2x3.py

	dosym ../share/${PN}/asciidoc3.py /usr/bin/asciidoc3
	dosym ../share/${PN}/a2x3.py /usr/bin/a2x3
	dosym ../share/${PN}/asciidoc3.py /usr/bin/asciidoc3.py
	dosym ../share/${PN}/a2x3.py /usr/bin/a2x3.py

	gunzip -c src/doc/asciidoc3.1.gz > "${T}/asciidoc3.1" || die
	gunzip -c src/doc/a2x3.1.gz > "${T}/a2x3.1" || die
	doman "${T}/asciidoc3.1" "${T}/a2x3.1"
	dodoc README.md CHANGELOG BUGS.txt INSTALL
}
