# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A cross-platform package to replace curses (mouse/keyboard input & text colours/positioning) and create ASCII animations"
HOMEPAGE="https://github.com/peterbrittain/asciimatics"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/dd/2e/146aca5e940c3b0df5c93c99e6eefe9c52e1e70a0e91fc98d2b466de61a4/asciimatics-1.15.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/asciimatics-1.15.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pillow
	dev-pypi/pyfiglet
	dev-pypi/wcwidth
"
# lockstep-pypi-deps: end
