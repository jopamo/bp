# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Virtual Python Environment builder"
HOMEPAGE="https://github.com/pypa/virtualenv"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ed/54/809199edc537dbace273495ac0884d13df26436e910a5ed4d0ec0a69806b/virtualenv-20.39.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/virtualenv-20.39.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/distlib
	dev-pypi/filelock
	dev-pypi/platformdirs
"
# lockstep-pypi-deps: end
