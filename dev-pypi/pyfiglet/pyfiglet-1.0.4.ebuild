# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Pure-python FIGlet implementation"
HOMEPAGE="https://github.com/pwaller/pyfiglet"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c8/e3/0a86276ad2c383ce08d76110a8eec2fe22e7051c4b8ba3fa163a0b08c428/pyfiglet-1.0.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pyfiglet-1.0.4"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
