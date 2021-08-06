# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs git-r3

DESCRIPTION="mapping tool for UTF-8 strings"
HOMEPAGE="https://github.com/JuliaStrings/utf8proc"
EGIT_REPO_URI="https://github.com/JuliaStrings/utf8proc.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=( "${FILESDIR}/${PN}-2.3.0-no-static.patch" )

_emake() {
	emake CC=$(tc-getCC) AR=$(tc-getAR) "$@"
}

src_compile() {
	_emake
}

src_install() {
	_emake DESTDIR="${D}" \
		prefix="${EPREFIX}/usr" \
		libdir="${EPREFIX}/usr/lib" \
		install

	dodir /usr/include/libutf8proc
	dosym ../utf8proc.h /usr/include/libutf8proc/utf8proc.h
}
