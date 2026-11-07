# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="type-lens is a Python template project designed to simplify the setup of a new project."
HOMEPAGE="https://litestar.dev/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f8/55/8846322acedf26cafb4a66dd23fdca6bc73cb3f8c0029040a9b96f5aa0dd/type_lens-0.2.6.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/type_lens-0.2.6"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
