# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="The ultimate Python library in building OAuth and OpenID Connect servers and clients."
HOMEPAGE="https://pypi.org/project/authlib/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d9/82/4d0603f30c1b4629b1f091bb266b0d7986434891d6940a8c87f8098db24e/authlib-1.7.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/authlib-1.7.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
	dev-pypi/joserfc
"
# lockstep-pypi-deps: end
