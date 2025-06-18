# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="ninja-compatible build tool written in C"
HOMEPAGE="https://github.com/michaelforney/samurai"

SNAPSHOT=737f702fed670acb25e5e70b4b802690df7a4a8b
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
