# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Optional static typing for Python"
HOMEPAGE="https://www.mypy-lang.org/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/cf/dc/7e6d49f04fca40b9dd5c752a51a432ffe67fb45200702bc9eee0cb4bbb26/mypy-2.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mypy-2.0.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/ast-serialize
	dev-pypi/librt
	dev-pypi/mypy-extensions
	dev-pypi/pathspec
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/ast-serialize[${PYTHON_USEDEP}]
	dev-pypi/librt[${PYTHON_USEDEP}]
	dev-pypi/mypy-extensions[${PYTHON_USEDEP}]
	dev-pypi/pathspec[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/tomli[${PYTHON_USEDEP}]
	dev-pypi/types-psutil[${PYTHON_USEDEP}]
	dev-pypi/types-setuptools[${PYTHON_USEDEP}]
	dev-pypi/typing-extensions[${PYTHON_USEDEP}]
"
