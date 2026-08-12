# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="cssselect parses CSS3 Selectors and translates them to XPath 1.0"
HOMEPAGE="https://github.com/scrapy/cssselect"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/8e/5a/6d6fcf922709391fac986f0a03ad4546f4f45b94d10aeb6c1ee041599993/cssselect-1.5.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cssselect-1.5.0"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
