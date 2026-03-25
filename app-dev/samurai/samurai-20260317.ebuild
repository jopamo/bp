# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="ninja-compatible build tool written in C"
HOMEPAGE="https://github.com/michaelforney/samurai"
SNAPSHOT=290b540f75a59dadd89fd041f0d22a570756dba5
SRC_URI="https://github.com/michaelforney/samurai/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/samurai-${SNAPSHOT}"

LICENSE="ISC Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	dosym -r /usr/bin/samu /usr/bin/ninja
}
