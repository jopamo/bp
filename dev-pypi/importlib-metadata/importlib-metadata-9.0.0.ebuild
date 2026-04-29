# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Read metadata from Python packages"
HOMEPAGE="https://pypi.org/project/importlib-metadata/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a9/01/15bb152d77b21318514a96f43af312635eb2500c96b55398d020c93d86ea/importlib_metadata-9.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/importlib_metadata-9.0.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/zipp
"
# lockstep-pypi-deps: end
