# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Tree-sitter is a parser generator tool and an incremental parsing library"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}-No-static-libs-gentoo.patch" )

src_prepare() {
	default
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" \
		  PREFIX="${EPREFIX}/usr" \
		  LIBDIR="${EPREFIX}/usr/lib" \
		  install
}
