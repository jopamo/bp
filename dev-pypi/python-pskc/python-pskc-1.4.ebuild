# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python module for handling PSKC files"
HOMEPAGE="https://arthurdejong.org/python-pskc/"
LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/bb/96/877a597fc0bd9a3ed33ada8b30a93f9705805dc43a330e048a8bb1078365/python_pskc-1.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python_pskc-1.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
	dev-pypi/python-dateutil
"
# lockstep-pypi-deps: end
