# Distributed under the terms of the GNU General Public License v2

EAPI=8

TS_BINDINGS=( python )

inherit tree-sitter-grammar flag-o-matic

DESCRIPTION="Bash grammar for Tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-bash"
SNAPSHOT=a06c2e4415e9bc0346c6b86d401879ffb44058f7
SRC_URI="https://github.com/tree-sitter/tree-sitter-bash/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/tree-sitter-bash-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	filter-flags -Wl,-z,defs
}
