# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Test utilities for code working with files and commands"
HOMEPAGE="https://pypi.org/project/testpath/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/08/ad/a3e7d580902f57e31d2181563fc4088894692bb6ef79b816344f27719cdc/testpath-0.6.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/testpath-0.6.0"
