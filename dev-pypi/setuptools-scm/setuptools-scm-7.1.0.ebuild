# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="the blessed package to manage your versions by scm tags"
HOMEPAGE="https://github.com/pypa/setuptools_scm/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/98/12/2c1e579bb968759fc512391473340d0661b1a8c96a59fb7c65b02eec1321/setuptools_scm-7.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/setuptools_scm-7.1.0"

BDEPEND="
	dev-pypi/packaging[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/typing-extensions[${PYTHON_USEDEP}]
"
