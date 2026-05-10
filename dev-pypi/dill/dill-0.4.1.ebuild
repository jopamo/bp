# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="serialize all of Python"
HOMEPAGE="https://github.com/uqfoundation/dill"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/81/e1/56027a71e31b02ddc53c7d65b01e68edf64dea2932122fe7746a516f75d5/dill-0.4.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dill-0.4.1"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
