# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A simple and portable single file AV1 OBU parser"
HOMEPAGE="https://github.com/dwbuiten/obuparse"
SNAPSHOT=8acb5193a64e5c8281c9f22805f75f044f5931f7
SRC_URI="https://github.com/dwbuiten/obuparse/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
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
}
