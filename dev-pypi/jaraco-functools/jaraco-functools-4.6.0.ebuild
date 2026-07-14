# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Functools like those found in stdlib"
HOMEPAGE="https://pypi.org/project/jaraco-functools/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6c/1f/c23395957d41ccf27c4e535c3d334c4051e5395b3752057ba4cbaec35c56/jaraco_functools-4.6.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jaraco_functools-4.6.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/more-itertools
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/coherent-licensed[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"

export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_JARACO_FUNCTOOLS="${PV}"
