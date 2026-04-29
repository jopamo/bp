# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="black"
DESCRIPTION="The uncompromising code formatter."
HOMEPAGE="https://pypi.org/project/black/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/click
	dev-pypi/mypy-extensions
	dev-pypi/packaging
	dev-pypi/pathspec
	dev-pypi/platformdirs
	dev-pypi/pytokens
"
# lockstep-pypi-deps: end
