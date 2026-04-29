# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="The little ASGI library that shines."
HOMEPAGE="https://github.com/Kludex/starlette"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/81/69/17425771797c36cded50b7fe44e850315d039f28b15901ab44839e70b593/starlette-1.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/starlette-1.0.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/anyio
"
# lockstep-pypi-deps: end
