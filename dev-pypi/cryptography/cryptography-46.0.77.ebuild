# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="cryptography is a package which provides cryptographic recipes and primitives to Python developers."
HOMEPAGE="https://gitlab.com/pjo/cryptography"
LICENSE="|| ( Apache-2.0 BSD ) PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"

SNAPSHOT=373dfb4637215425b21222317b9db7bea9fad487
SRC_URI="https://gitlab.com/pjo/cryptography/-/archive/${SNAPSHOT}/cryptography-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cryptography-${SNAPSHOT}"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
	dev-pypi/six
"
# lockstep-pypi-deps: end
