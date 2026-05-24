# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	app-crypto/acme
	app-crypto/cryptography
	dev-pypi/configargparse
	dev-pypi/configobj
	dev-pypi/distro
	dev-pypi/josepy
	dev-pypi/parsedatetime
	dev-pypi/pyrfc3339
"
# lockstep-pypi-deps: end
DESCRIPTION="Let’s Encrypt client to automate deployment of X.509 certificates"

HOMEPAGE="https://github.com/certbot/certbot"
KEYWORDS="amd64 arm64"
SNAPSHOT=750b9997defdf3be12f826d7e2ea98e7c7572076
SRC_URI="https://github.com/certbot/certbot/archive/${SNAPSHOT}.tar.gz -> certbot-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/certbot-${SNAPSHOT}/certbot"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="selinux"

BDEPEND="
	test? (
		dev-pypi/pytest[${PYTHON_USEDEP}]
		dev-pypi/pytest-cov[${PYTHON_USEDEP}]
		dev-pypi/pytest-xdist[${PYTHON_USEDEP}]
		dev-pypi/typing-extensions[${PYTHON_USEDEP}]
	)
"

# See certbot/setup.py for acme >= dep
RDEPEND="
	>=app-crypto/acme-${PV}[${PYTHON_USEDEP}]
	>=dev-pypi/configargparse-1.5.3[${PYTHON_USEDEP}]
	>=dev-pypi/configobj-5.0.6[${PYTHON_USEDEP}]
	>=app-crypto/cryptography-43.0.0[${PYTHON_USEDEP}]
	>=dev-pypi/distro-1.0.1[${PYTHON_USEDEP}]
	>=dev-pypi/josepy-2.0.0[${PYTHON_USEDEP}]
	>=dev-pypi/parsedatetime-2.6[${PYTHON_USEDEP}]
	dev-pypi/pyrfc3339[${PYTHON_USEDEP}]
	selinux? ( sec-policy/selinux-certbot )
"

distutils_enable_sphinx docs dev-py/sphinx-rtd-theme
distutils_enable_tests pytest
