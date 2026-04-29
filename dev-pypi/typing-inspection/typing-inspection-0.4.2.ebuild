# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Runtime typing introspection tools"
HOMEPAGE="https://github.com/pydantic/typing-inspection"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/55/e3/70399cb7dd41c10ac53367ae42139cf4b1ca5f36bb3dc6c9d33acdb43655/typing_inspection-0.4.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/typing_inspection-0.4.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
