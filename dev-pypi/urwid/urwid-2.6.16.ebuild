# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A full-featured console (xterm et al.) user interface library"
HOMEPAGE="https://urwid.org/"
LICENSE="LGPL-2.1-only"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/98/21/ad23c9e961b2d36d57c63686a6f86768dd945d406323fb58c84f09478530/urwid-2.6.16.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/urwid-2.6.16"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typing-extensions
	dev-pypi/wcwidth
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
