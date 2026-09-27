# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Poetry PEP 517 Build Backend"
HOMEPAGE="https://github.com/python-poetry/poetry-core"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/42/b5/50f1fda26c4fe5b1d6ce5cdf0391bdfa1ca12fdcb8ad68344d5cf678fc90/poetry_core-2.5.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/poetry_core-2.5.0"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
