# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="PEP 621 metadata parsing"
HOMEPAGE="https://github.com/pypa/pyproject-metadata"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/83/fa/8bf4fa41adfebd95dce360afe3f5fca243a17932089d3d5486e95ca44c57/pyproject_metadata-0.11.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pyproject_metadata-0.11.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
