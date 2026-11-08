# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="High-level concurrency and networking framework on top of asyncio or Trio"
HOMEPAGE="https://pypi.org/project/anyio/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a1/98/7e457a3b014976887a050561955c0b76e1e7e2d6e27b78ecef2ef80518f2/anyio-4.16.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/anyio-4.16.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/idna
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"

export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_ANYIO="${PV}"
