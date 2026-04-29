# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Container class boilerplate killer."
HOMEPAGE="https://github.com/ionelmc/python-fields"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/18/68/b922b5b0b2c1d99171c0ed9ad10296b55ee644eb1fa2fd5e45cafe56ae33/fields-5.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fields-5.0.0"
