# Distributed under the terms of the GNU General Public License v2

EAPI=8

TS_BINDINGS=( python )

inherit tree-sitter-grammar flag-o-matic

DESCRIPTION="Bash grammar for Tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-bash"

SNAPSHOT=f8fb3274f72a30896075585b32b0c54cad65c086
SRC_URI="https://github.com/tree-sitter/tree-sitter-bash/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	filter-flags -Wl,-z,defs
}
