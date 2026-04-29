# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="pytest: simple powerful testing with Python"
HOMEPAGE="https://docs.pytest.org/en/latest/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/7d/0d/549bd94f1a0a402dc8cf64563a117c0f3765662e2e668477624baeec44d5/pytest-9.0.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytest-9.0.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/iniconfig
	dev-pypi/packaging
	dev-pypi/pluggy
	dev-pypi/pygments
"
# lockstep-pypi-deps: end
