# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="mypy"
DESCRIPTION="Optional static typing for Python"
HOMEPAGE="https://www.mypy-lang.org/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/librt
	dev-pypi/mypy-extensions
	dev-pypi/pathspec
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
