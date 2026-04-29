# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="TCP port monitoring and discovery"
HOMEPAGE="https://pypi.org/project/portend/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b7/57/be90f42996fc4f57d5742ef2c95f7f7bb8e9183af2cc11bff8e7df338888/portend-3.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/portend-3.2.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/tempora
"
# lockstep-pypi-deps: end
