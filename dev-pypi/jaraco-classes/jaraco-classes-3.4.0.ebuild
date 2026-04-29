# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Utility functions for Python class constructs"
HOMEPAGE="https://github.com/jaraco/jaraco.classes"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/06/c0/ed4a27bc5571b99e3cff68f8a9fa5b56ff7df1c2251cc715a652ddd26402/jaraco.classes-3.4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jaraco.classes-3.4.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/more-itertools
"
# lockstep-pypi-deps: end
