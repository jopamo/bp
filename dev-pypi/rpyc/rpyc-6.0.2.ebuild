# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Remote Python Call (RPyC) is a transparent and symmetric distributed computing library"
HOMEPAGE="https://rpyc.readthedocs.org"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/8b/e7/1c17410673b634f4658bb5d2232d0c4507432a97508b2c6708e59481644a/rpyc-6.0.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rpyc-6.0.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/plumbum
"
# lockstep-pypi-deps: end
