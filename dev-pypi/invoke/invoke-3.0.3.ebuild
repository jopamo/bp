# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Pythonic task execution"
HOMEPAGE="https://pypi.org/project/invoke/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/33/f6/227c48c5fe47fa178ccf1fda8f047d16c97ba926567b661e9ce2045c600c/invoke-3.0.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/invoke-3.0.3"
