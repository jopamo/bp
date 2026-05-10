# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Dynamic versioning based on VCS tags for uv/hatch project"
HOMEPAGE="https://github.com/ninoseki/uv-dynamic-versioning/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/15/ef/63270118de5af8f45ba417946290b63f86b0b2a7d07d739d5dc619462711/uv_dynamic_versioning-0.14.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uv_dynamic_versioning-0.14.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-py/jinja
	dev-pypi/dunamai
	dev-pypi/hatchling
	dev-pypi/tomlkit
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
