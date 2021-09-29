# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Quote arguments or standard input for usage in POSIX shell by eval"
HOMEPAGE="https://github.com/vaeth/quoter/"
SRC_URI="https://github.com/vaeth/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	emake CC="$(tc-getCC)" EPREFIX="${EPREFIX}"
}

src_install() {
	emake DESTDIR="${ED}" EPREFIX="${EPREFIX}" install
	cleanup_install
}
