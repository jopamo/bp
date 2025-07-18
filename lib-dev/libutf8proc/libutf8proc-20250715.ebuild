# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="mapping tool for UTF-8 strings"
HOMEPAGE="https://github.com/JuliaStrings/utf8proc"
SNAPSHOT=20d192ac17f8a746f587fa1d0e7f52edd2967f92
SRC_URI="https://github.com/JuliaStrings/utf8proc/archive/${SNAPSHOT}.tar.gz -> utf8proc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/utf8proc-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=( "${FILESDIR}/libutf8proc-2.3.0-no-static.patch" )

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
