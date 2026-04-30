# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

DESCRIPTION="SSH2 protocol library"
HOMEPAGE="https://pypi.org/project/paramiko/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="paramiko"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/bcrypt
	dev-pypi/cryptography
	dev-pypi/invoke
	dev-pypi/pynacl
"
# lockstep-pypi-deps: end
