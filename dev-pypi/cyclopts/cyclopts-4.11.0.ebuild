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

SRC_URI="https://files.pythonhosted.org/packages/f9/fa/eff8f1abae783bade9b5e9bafafd0040d4dbf51988f9384bfdc0326ba1fc/cyclopts-4.11.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cyclopts-4.11.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/docstring-parser
	dev-pypi/rich
	dev-pypi/rich-rst
"
# lockstep-pypi-deps: end
