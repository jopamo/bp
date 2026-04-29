# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="jsonref is a library for automatic dereferencing of JSON Reference objects for Python."
HOMEPAGE="https://pypi.org/project/jsonref/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/aa/0d/c1f3277e90ccdb50d33ed5ba1ec5b3f0a242ed8c1b1a85d3afeb68464dca/jsonref-1.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jsonref-1.1.0"
