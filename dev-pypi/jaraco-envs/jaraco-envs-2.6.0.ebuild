# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="jaraco-envs"
DESCRIPTION="Classes for orchestrating Python (virtual) environments"
HOMEPAGE="https://github.com/jaraco/jaraco.envs"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/path
	dev-pypi/tox
	dev-pypi/virtualenv
"
# lockstep-pypi-deps: end
