# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python binding to the Networking and Cryptography (NaCl) library"
HOMEPAGE="https://github.com/pyca/pynacl/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d9/9a/4019b524b03a13438637b11538c82781a5eda427394380381af8f04f467a/pynacl-1.6.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pynacl-1.6.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
"
# lockstep-pypi-deps: end
