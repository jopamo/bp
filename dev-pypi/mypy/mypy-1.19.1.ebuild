# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Optional static typing for Python"
HOMEPAGE="https://www.mypy-lang.org/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f5/db/4efed9504bc01309ab9c2da7e352cc223569f05478012b5d9ece38fd44d2/mypy-1.19.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mypy-1.19.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/librt
	dev-pypi/mypy-extensions
	dev-pypi/pathspec
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
