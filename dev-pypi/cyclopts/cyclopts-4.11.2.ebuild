# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Intuitive, easy CLIs based on type hints."
HOMEPAGE="https://github.com/BrianPugh/cyclopts"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/e4/f7/3ee212c1bc314551094fc8fda7b4b63c647ac5c32d06daa285d04d33edfc/cyclopts-4.11.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cyclopts-4.11.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/docstring-parser
	dev-pypi/rich
	dev-pypi/rich-rst
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
