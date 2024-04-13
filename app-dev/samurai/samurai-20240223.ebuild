# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="ninja-compatible build tool written in C"
HOMEPAGE="https://github.com/michaelforney/samurai"

SNAPSHOT=189023533035ecc30848ba8dffc25c9139928f89
SRC_URI="https://github.com/michaelforney/samurai/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
