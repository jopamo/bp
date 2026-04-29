# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="pypiserver"
DESCRIPTION="A minimal PyPI server for use with pip/easy_install."
HOMEPAGE="https://github.com/pypiserver/pypiserver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/legacy-cgi
	dev-pypi/packaging
	dev-pypi/pip
"
# lockstep-pypi-deps: end
