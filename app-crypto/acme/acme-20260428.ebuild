# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
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
# The requirement is really 17.5.0 but easier to require latest stable >= 23.1.1
# to avoid broken 23.1.0.
RDEPEND="
	dev-pypi/chardet[${PYTHON_USEDEP}]
	>=app-crypto/cryptography-3.2.1[${PYTHON_USEDEP}]
	>=dev-pypi/josepy-1.13.0[${PYTHON_USEDEP}]
	>=dev-pypi/pyopenssl-23.1.1[${PYTHON_USEDEP}]
	dev-pypi/pyrfc3339[${PYTHON_USEDEP}]
	>=dev-pypi/pytz-2019.3[${PYTHON_USEDEP}]
	>=dev-pypi/requests-2.20.0[${PYTHON_USEDEP}]
	>=dev-pypi/requests-toolbelt-0.3.0[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs dev-py/sphinx-rtd-theme
distutils_enable_tests pytest
