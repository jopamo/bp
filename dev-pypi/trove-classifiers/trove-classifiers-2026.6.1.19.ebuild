# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Canonical source for classifiers on PyPI (pypi.org)."
HOMEPAGE="https://github.com/pypa/trove-classifiers"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c2/e3/7ca82ee24c82d344584abd5b8637b3bd056f2900226e8d82fc22f1184b92/trove_classifiers-2026.6.1.19.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trove_classifiers-2026.6.1.19"

BDEPEND="
	dev-pypi/calver[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
