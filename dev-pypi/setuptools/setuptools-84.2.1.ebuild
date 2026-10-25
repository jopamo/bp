# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Most extensible Python build backend with support for C/C++ extension modules"
HOMEPAGE="https://pypi.org/project/setuptools/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/70/b3/c19426f783614d625699a4b247faf628ea9ab1db228674491767b417f9e1/setuptools-84.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/setuptools-84.2.1"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
