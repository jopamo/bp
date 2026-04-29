# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python interface for c-ares"
HOMEPAGE="http://github.com/saghul/pycares"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/df/a0/9c823651872e6a0face3f0311de2a40c8bbcb9c8dcb15680bd019ac56ac7/pycares-5.0.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pycares-5.0.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
"
# lockstep-pypi-deps: end
