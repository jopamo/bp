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

SRC_URI="https://files.pythonhosted.org/packages/a9/d2/f4d173e22df740bc37b1db102b386ba719b66e95b0f0d751f556b387e6d2/anyio-4.15.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/anyio-4.15.1"

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
