# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Lockstep-managed PyPI dependency cppy"
HOMEPAGE="https://github.com/nucleic/cppy"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/45/ed/b35645a1b285bce356f30cc0fe77a042375c385660ccd61e0cdc4c1f7c44/cppy-1.3.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cppy-1.3.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/setuptools
"
# lockstep-pypi-deps: end
