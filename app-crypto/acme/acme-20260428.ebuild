# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	app-crypto/cryptography
	dev-pypi/josepy
	dev-pypi/pyopenssl
	dev-pypi/pyrfc3339
	dev-pypi/requests
"
# lockstep-pypi-deps: end
PARENT_PN="certbot"
PARENT_P="${PARENT_PN}-${PV}"

DESCRIPTION="An implementation of the ACME protocol"
HOMEPAGE="https://letsencrypt.org"
SRC_URI="https://github.com/certbot/certbot/archive/v${PV}.tar.gz -> ${PARENT_P}.gh.tar.gz"
SNAPSHOT=9ec4105ff3c00582b628de4761260b0b0e643da8
SRC_URI="https://github.com/certbot/certbot/archive/${SNAPSHOT}.tar.gz -> acme-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PARENT_PN}-${SNAPSHOT}/acme"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		dev-pypi/pytest[${PYTHON_USEDEP}]
		dev-pypi/pytest-xdist[${PYTHON_USEDEP}]
		dev-pypi/typing-extensions[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	>=app-crypto/cryptography-43.0.0[${PYTHON_USEDEP}]
	>=dev-pypi/josepy-2.0.0[${PYTHON_USEDEP}]
	>=dev-pypi/pyopenssl-25.0.0[${PYTHON_USEDEP}]
	dev-pypi/pyrfc3339[${PYTHON_USEDEP}]
	>=dev-pypi/requests-2.25.1[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs dev-py/sphinx-rtd-theme
distutils_enable_tests pytest
