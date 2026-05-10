# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="ACME protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/certbot"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/18/a2/8dcd9f32e68985c08696c66838c21f3aa42089a510bf96b24ebcb9cd4729/acme-5.5.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/acme-5.5.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
	dev-pypi/josepy
	dev-pypi/pyopenssl
	dev-pypi/pyrfc3339
	dev-pypi/requests
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
