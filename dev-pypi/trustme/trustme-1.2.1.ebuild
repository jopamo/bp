# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="#1 quality TLS certs while you wait, for the discerning tester"
HOMEPAGE="https://github.com/python-trio/trustme"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/4b/c5/931476f4cf1cd9e736f32651005078061a50dc164a2569fb874e00eb2786/trustme-1.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trustme-1.2.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
	dev-pypi/idna
"
# lockstep-pypi-deps: end
