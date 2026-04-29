# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Measures the displayed width of unicode strings in a terminal"
HOMEPAGE="https://github.com/jquast/wcwidth"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/35/a2/8e3becb46433538a38726c948d3399905a4c7cabd0df578ede5dc51f0ec2/wcwidth-0.6.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/wcwidth-0.6.0"
