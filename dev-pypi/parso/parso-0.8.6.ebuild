# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A Python Parser"
HOMEPAGE="https://github.com/davidhalter/parso"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/81/76/a1e769043c0c0c9fe391b702539d594731a4362334cdf4dc25d0c09761e7/parso-0.8.6.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/parso-0.8.6"
