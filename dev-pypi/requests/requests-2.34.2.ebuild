# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python HTTP for Humans."
HOMEPAGE="https://pypi.org/project/requests/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/requests-2.34.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/certifi
	dev-pypi/charset-normalizer
	dev-pypi/idna
	dev-pypi/urllib3
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
