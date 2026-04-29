# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="The next generation HTTP client."
HOMEPAGE="https://github.com/encode/httpx"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/httpx-0.28.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
	dev-pypi/certifi
	dev-pypi/httpcore
	dev-pypi/idna
"
# lockstep-pypi-deps: end
