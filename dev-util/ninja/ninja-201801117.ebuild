# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-any-r1 toolchain-funcs

SNAPSHOT=5a78423193c48cae4800eb1ec44b62d14ae03920

SRC_URI="https://github.com/ninja-build/ninja/archive/${SNAPSHOT}.zip -> ${P}.zip"
KEYWORDS="amd64 arm64 x86"
S=${WORKDIR}/${PN}-${SNAPSHOT}
DESCRIPTION="A small build system similar to make"
HOMEPAGE="https://ninja-build.org/"

LICENSE="Apache-2.0"
SLOT="0"

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
