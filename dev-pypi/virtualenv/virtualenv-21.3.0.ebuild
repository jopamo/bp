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

SRC_URI="https://files.pythonhosted.org/packages/3f/8b/6331f7a7fe70131c301106ec1e7cf23e2501bf7d4ca3636805801ca191bb/virtualenv-21.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/virtualenv-21.3.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/distlib
	dev-pypi/filelock
	dev-pypi/platformdirs
	dev-pypi/python-discovery
"
# lockstep-pypi-deps: end
