# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Pytest plugin for measuring coverage."
HOMEPAGE="https://pypi.org/project/pytest-cov/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b1/51/a849f96e117386044471c8ec2bd6cfebacda285da9525c9106aeb28da671/pytest_cov-7.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytest_cov-7.1.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/coverage
	dev-pypi/pluggy
	dev-pypi/pytest
"
# lockstep-pypi-deps: end
