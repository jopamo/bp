# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="SSH2 protocol library"
HOMEPAGE="https://pypi.org/project/paramiko/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/62/93/dcc25d52f49022ae6175d15e6bd751f1acc99b98bc61fc55e5155a7be2e7/paramiko-5.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/paramiko-5.0.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-py/bcrypt
	dev-py/pynacl
	dev-pypi/cryptography
	dev-pypi/invoke
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
