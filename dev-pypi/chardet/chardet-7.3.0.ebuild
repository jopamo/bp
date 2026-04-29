# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Universal character encoding detector"
HOMEPAGE="https://github.com/chardet/chardet"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/3e/af/8d6ad988a6a4b9830c4e39e4c2e390e3037465b76a5e32e92273df27a973/chardet-7.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/chardet-7.3.0"
