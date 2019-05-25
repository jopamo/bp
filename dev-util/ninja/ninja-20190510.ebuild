# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=20b30dac6698d119e7797b34d6ed2c4ed8f48417

inherit python-any-r1 toolchain-funcs

DESCRIPTION="A small build system similar to make"
HOMEPAGE="https://ninja-build.org/"
SRC_URI="https://github.com/ninja-build/ninja/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="Apache-2.0"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="
	${PYTHON_DEPS}
"
run_for_build() {
	if tc-is-cross-compiler; then
		local -x AR=$(tc-getBUILD_AR)
		local -x CXX=$(tc-getBUILD_CXX)
		local -x CFLAGS=${BUILD_CXXFLAGS}
		local -x LDFLAGS=${BUILD_LDFLAGS}
	fi
	"$@"
}

src_compile() {
	tc-export AR CXX

	export CFLAGS=${CXXFLAGS}

	run_for_build "${PYTHON}" configure.py --bootstrap --verbose || die

	ln ninja ninja-build || die
}

src_install() {
	dobin ninja
}
