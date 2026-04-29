# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Capture the outcome of Python function calls."
HOMEPAGE="https://github.com/python-trio/outcome"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/98/df/77698abfac98571e65ffeb0c1fba8ffd692ab8458d617a0eed7d9a8d38f2/outcome-1.3.0.post0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/outcome-1.3.0.post0"
