# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="The Real First Universal Charset Detector. Open, modern and actively maintained alternative to Chardet."
HOMEPAGE="https://pypi.org/project/charset-normalizer/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/bd/2a/23f34ec9d04624958e137efdc394888716353190e75f25dd22c7a2c7a8aa/charset_normalizer-3.4.9.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/charset_normalizer-3.4.9"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
