# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="pytest plugin to abort hanging tests"
HOMEPAGE="https://github.com/pytest-dev/pytest-timeout"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ac/82/4c9ecabab13363e72d880f2fb504c5f750433b2b6f16e99f4ec21ada284c/pytest_timeout-2.4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytest_timeout-2.4.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pytest
"
# lockstep-pypi-deps: end
