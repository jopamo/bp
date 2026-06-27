# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	app-emu/capstone
"
# lockstep-pypi-deps: end
DESCRIPTION="Search for gadgets in binaries to facilitate your ROP exploitation"
HOMEPAGE="https://shell-storm.org/project/ROPgadget/"
SNAPSHOT=b6e3fe31af46d7e045fef99a3ab19ccbcea5c2f6
SRC_URI="https://github.com/JonathanSalwan/ROPgadget/archive/${SNAPSHOT}.tar.gz -> ropgadget-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ROPgadget-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	${PYTHON_DEPS}
	>=app-emu/capstone-5.0.1[python,${PYTHON_USEDEP}]
"

src_test() {
	pushd test-suite-binaries || die
	./test.sh || die
	popd || die
}
