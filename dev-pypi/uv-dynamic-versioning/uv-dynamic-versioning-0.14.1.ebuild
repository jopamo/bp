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

SRC_URI="https://files.pythonhosted.org/packages/6f/c8/fa500ee29af69cfeeea5ff6d6597919f1989b2e3f1a236c3006bdb21d320/uv_dynamic_versioning-0.14.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uv_dynamic_versioning-0.14.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/dunamai
	dev-pypi/hatchling
	dev-pypi/jinja
	dev-pypi/tomlkit
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
