# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

DESCRIPTION="High-level concurrency and networking framework on top of asyncio or Trio"
HOMEPAGE="https://pypi.org/project/anyio/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="anyio"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/idna
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
