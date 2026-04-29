# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Functools like those found in stdlib"
HOMEPAGE="https://pypi.org/project/jaraco-functools/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/0f/27/056e0638a86749374d6f57d0b0db39f29509cce9313cf91bdc0ac4d91084/jaraco_functools-4.4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jaraco_functools-4.4.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/more-itertools
"
# lockstep-pypi-deps: end
