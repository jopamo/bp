# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1

DESCRIPTION="A utility to fetch and download python packages"
HOMEPAGE="https://github.com/frostming/unearth"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/47/1f/cdad555c0e8643232cce619e8d88d5bec81b4d41e4cc1c65bee8a51a4750/unearth-0.18.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/unearth-0.18.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/httpx
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
