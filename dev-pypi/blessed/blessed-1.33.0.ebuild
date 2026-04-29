# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Easy, practical library for making terminal apps, by providing an elegant, well-documented interface to Colors, Keyboard input, and screen Positioning capabilities."
HOMEPAGE="https://github.com/jquast/blessed"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/68/5c/92dc10a25a4eafb4b9bef5dad522a0b7d5d5b55d2d76f9a6721b2e49ca2c/blessed-1.33.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/blessed-1.33.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/wcwidth
"
# lockstep-pypi-deps: end
