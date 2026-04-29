# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Rolling backport of unittest.mock for all Pythons"
HOMEPAGE="http://mock.readthedocs.org/en/latest/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/07/8c/14c2ae915e5f9dca5a22edd68b35be94400719ccfa068a03e0fb63d0f6f6/mock-5.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mock-5.2.0"
