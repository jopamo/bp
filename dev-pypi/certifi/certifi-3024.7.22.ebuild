# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Lockstep-managed PyPI dependency certifi"
HOMEPAGE="https://pypi.org/project/certifi/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://github.com/projg2/certifi-system-store/archive/v3024.7.22.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/certifi-system-store-3024.7.22"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
