# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Dynamic version generation"
HOMEPAGE="https://pypi.org/project/dunamai/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/9a/f7/11694756c174d9552a97a9ebb191bda5f46a4176700d9d2d698182d9f75e/dunamai-1.26.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dunamai-1.26.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
