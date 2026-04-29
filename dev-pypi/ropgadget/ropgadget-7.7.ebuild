# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="This tool lets you search your gadgets on your binaries to facilitate your ROP exploitation."
HOMEPAGE="https://github.com/JonathanSalwan/ROPgadget"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/88/9a/d5290486bb97f2bc9f7801e90659c0b26707d7997d8ff851846efc869db7/ropgadget-7.7.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ropgadget-7.7"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/capstone
"
# lockstep-pypi-deps: end
