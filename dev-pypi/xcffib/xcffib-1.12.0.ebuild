# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="xcffib is the XCB binding for python"
HOMEPAGE="http://github.com/tych0/xcffib"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/28/84/ca4a0d870178ad21dc5d6721c782d924b2aa8ced93bcf7fe715c1eae01fd/xcffib-1.12.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/xcffib-1.12.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
"
# lockstep-pypi-deps: end
