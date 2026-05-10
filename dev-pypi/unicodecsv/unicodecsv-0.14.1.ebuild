# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python2's stdlib csv module is nice, but it doesn't support unicode. This module is a drop-in replacement which *does*."
HOMEPAGE="https://github.com/jdunck/python-unicodecsv"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6f/a4/691ab63b17505a26096608cc309960b5a6bdf39e4ba1a793d5f9b1a53270/unicodecsv-0.14.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/unicodecsv-0.14.1"
