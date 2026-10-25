# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="SSH2 protocol library"
HOMEPAGE="https://pypi.org/project/paramiko/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/76/cb/b1fde76618d84b1acf54d3d03d2b833ba5878afd12b9899346cc080f209d/paramiko-5.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/paramiko-5.1.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	app-crypto/vesk
	dev-pypi/bcrypt
	dev-pypi/invoke
	dev-pypi/pynacl
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
