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

SRC_URI="https://files.pythonhosted.org/packages/d1/db/7ef3487e0fb0049ddb5ce41d3a49c235bf9ad299b6a25d5780a89f19230f/pytest-9.0.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytest-9.0.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/iniconfig
	dev-pypi/packaging
	dev-pypi/pluggy
	dev-pypi/pygments
"
# lockstep-pypi-deps: end
