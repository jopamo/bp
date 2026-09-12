# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Backport of compression.zstd"
HOMEPAGE="https://github.com/rogdham/backports.zstd"
LICENSE="PSF-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/75/f0/9ba1b05811aa5f5434f69768253129460a5744e1814f359efba39a01ce20/backports_zstd-1.7.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/backports_zstd-1.7.0"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
