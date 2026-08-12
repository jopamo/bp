# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Code coverage measurement for Python"
HOMEPAGE="https://github.com/coveragepy/coveragepy"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/be/c3/4f2195f512fb172aa425a8803a874b2baa9ba7f80ff7b6080998761fc701/coverage-7.15.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/coverage-7.15.4"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
