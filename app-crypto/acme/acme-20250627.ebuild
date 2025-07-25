# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

PARENT_PN="certbot"
PARENT_P="${PARENT_PN}-${PV}"

DESCRIPTION="An implementation of the ACME protocol"
HOMEPAGE="https://letsencrypt.org"
SRC_URI="https://github.com/certbot/certbot/archive/v${PV}.tar.gz -> ${PARENT_P}.gh.tar.gz"
SNAPSHOT=295d8c3c49ad88771acc47b0f929c41177745a93
SRC_URI="https://github.com/certbot/certbot/archive/${SNAPSHOT}.tar.gz -> acme-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PARENT_PN}-${SNAPSHOT}/acme"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
"
# The requirement is really 17.5.0 but easier to require latest stable >= 23.1.1
# to avoid broken 23.1.0.
RDEPEND="
	dev-python/chardet[${PYTHON_USEDEP}]
	>=app-crypto/cryptography-3.2.1[${PYTHON_USEDEP}]
	>=dev-python/josepy-1.13.0[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-23.1.1[${PYTHON_USEDEP}]
	dev-python/pyrfc3339[${PYTHON_USEDEP}]
	>=dev-python/pytz-2019.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
	>=dev-python/requests-toolbelt-0.3.0[${PYTHON_USEDEP}]
"

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
distutils_enable_tests pytest
