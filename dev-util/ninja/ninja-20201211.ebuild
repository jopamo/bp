# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=68f971460bb21abd59dfe6253e35a55c3e1cfc64

inherit python-any-r1 toolchain-funcs

DESCRIPTION="A small build system similar to make"
HOMEPAGE="https://ninja-build.org/"
SRC_URI="https://github.com/ninja-build/ninja/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="${PYTHON_DEPS}"

src_compile() {
	tc-export AR CXX

	export CFLAGS=${CXXFLAGS}

	"${PYTHON}" configure.py --bootstrap --verbose || die

	ln ninja ninja-build || die
}

src_install() {
	dobin ninja
}
