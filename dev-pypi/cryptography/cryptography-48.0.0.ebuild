# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="cryptography is a package which provides cryptographic recipes and primitives to Python developers."
HOMEPAGE="https://github.com/pyca/cryptography"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/9f/a9/db8f313fdcd85d767d4973515e1db101f9c71f95fced83233de224673757/cryptography-48.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cryptography-48.0.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
"
# lockstep-pypi-deps: end

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
	dev-pypi/cffi[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
