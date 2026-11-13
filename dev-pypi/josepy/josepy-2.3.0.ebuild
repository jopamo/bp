# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="JOSE protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/josepy"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/8d/6f/c1b17c5a4978f80d10fc46257ef84fa09648265df0939639ce50d5896886/josepy-2.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/josepy-2.3.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	app-crypto/vesk
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
