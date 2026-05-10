# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Python library to build pretty command line user prompts ������"
HOMEPAGE="https://pypi.org/project/questionary/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f6/45/eafb0bba0f9988f6a2520f9ca2df2c82ddfa8d67c95d6625452e97b204a5/questionary-2.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/questionary-2.1.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/prompt-toolkit
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
