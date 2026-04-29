# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="zc-lockfile"
DESCRIPTION="Basic inter-process locks"
HOMEPAGE="https://github.com/zopefoundation/zc.lockfile"
LICENSE="ZPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/setuptools
"
# lockstep-pypi-deps: end
