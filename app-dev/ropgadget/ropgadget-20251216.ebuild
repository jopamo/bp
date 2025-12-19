# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Search for gadgets in binaries to facilitate your ROP exploitation"
HOMEPAGE="https://shell-storm.org/project/ROPgadget/"
SNAPSHOT=4e5d4da5a92a723f823ee0dc00dc0cfcfabe19f1
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
