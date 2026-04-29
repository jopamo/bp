# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="High-level concurrency and networking framework on top of asyncio or Trio"
HOMEPAGE="https://pypi.org/project/anyio/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/19/14/2c5dd9f512b66549ae92767a9c7b330ae88e1932ca57876909410251fe13/anyio-4.13.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/anyio-4.13.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/idna
"
# lockstep-pypi-deps: end
