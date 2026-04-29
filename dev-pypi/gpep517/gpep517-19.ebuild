# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Python package builder and installer for non-pip-centric world"
HOMEPAGE="https://pypi.org/project/gpep517/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/61/6e/ff04f422467ec5438b6236a42671a655419bb135b383facb6c7c65060fe6/gpep517-19.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gpep517-19"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/installer
"
# lockstep-pypi-deps: end
