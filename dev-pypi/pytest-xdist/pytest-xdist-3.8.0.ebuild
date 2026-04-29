# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="pytest-xdist"
DESCRIPTION="pytest xdist plugin for distributed testing, most importantly across multiple CPUs"
HOMEPAGE="https://github.com/pytest-dev/pytest-xdist"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/execnet
	dev-pypi/pytest
"
# lockstep-pypi-deps: end
