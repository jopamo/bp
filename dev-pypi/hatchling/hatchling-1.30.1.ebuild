# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Modern, extensible Python build backend"
HOMEPAGE="https://hatch.pypa.io/latest/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/63/4c/8717ccb844b4fa5a5ba6352e97d743ed24e9a22cf90b7c109c17030a46a1/hatchling-1.30.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hatchling-1.30.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/pathspec
	dev-pypi/pluggy
	dev-pypi/trove-classifiers
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
