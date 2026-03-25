# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="A simple and portable single file AV1 OBU parser"
HOMEPAGE="https://github.com/dwbuiten/obuparse"
SNAPSHOT=c2156b4a133714d0a9c04a7cd341efb1af415a33
SRC_URI="https://github.com/dwbuiten/obuparse/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	qa-policy-configure

	make \
		CC="$(tc-getCC)" \
		AR="$(tc-getAR)" \
		PREFIX="${EPREFIX}"/usr
}

src_install() {
	insinto /usr/include
	doins obuparse.h

	ln -s libobuparse.so libobuparse.so.1
	insinto /usr/lib
	doins libobuparse.a
	doins libobuparse.so
	doins libobuparse.so.1

	qa-policy-install
}
