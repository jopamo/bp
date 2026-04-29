# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Manipulate well-formed Roman numerals"
HOMEPAGE="https://pypi.org/project/roman-numerals/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ae/f9/41dc953bbeb056c17d5f7a519f50fdf010bd0553be2d630bc69d1e022703/roman_numerals-4.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/roman_numerals-4.1.0"
