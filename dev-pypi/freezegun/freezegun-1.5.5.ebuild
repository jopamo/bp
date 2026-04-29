# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Let your Python tests travel through time"
HOMEPAGE="https://github.com/spulec/freezegun"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/95/dd/23e2f4e357f8fd3bdff613c1fe4466d21bfb00a6177f238079b17f7b1c84/freezegun-1.5.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/freezegun-1.5.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/python-dateutil
"
# lockstep-pypi-deps: end
