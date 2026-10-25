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

SRC_URI="https://files.pythonhosted.org/packages/ff/9c/13569626440e88f09d16f43ec1c2aa0d10a523be2811414580d1cfb7c9f3/backports_zstd-1.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/backports_zstd-1.8.0"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
