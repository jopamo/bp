# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="flit"
DESCRIPTION="A simple packaging tool for simple packages."
HOMEPAGE="https://pypi.org/project/flit/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/docutils
	dev-pypi/flit-core
	dev-pypi/pip
	dev-pypi/requests
	dev-pypi/tomli-w
"
# lockstep-pypi-deps: end
