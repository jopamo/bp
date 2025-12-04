# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

KEYWORDS="amd64 arm arm64 ~ppc64 ~riscv x86"

DESCRIPTION="Let’s Encrypt client to automate deployment of X.509 certificates"
HOMEPAGE="
	https://github.com/certbot/certbot
	https://letsencrypt.org/
"
SNAPSHOT=8c4e3080ddd72123420f8882c8b96921c8d33304
SRC_URI="https://github.com/certbot/certbot/archive/${SNAPSHOT}.tar.gz -> certbot-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/certbot-${SNAPSHOT}/certbot"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="selinux"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
"

# See certbot/setup.py for acme >= dep
RDEPEND="
	>=app-crypto/acme-${PV}[${PYTHON_USEDEP}]
	>=dev-python/configargparse-1.5.3[${PYTHON_USEDEP}]
	>=dev-python/configobj-5.0.6[${PYTHON_USEDEP}]
	>=app-crypto/cryptography-3.2.1[${PYTHON_USEDEP}]
	>=dev-python/distro-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/josepy-1.13.0[${PYTHON_USEDEP}]
	>=dev-python/parsedatetime-2.4[${PYTHON_USEDEP}]
	dev-python/pyrfc3339[${PYTHON_USEDEP}]
	>=dev-python/pytz-2019.3[${PYTHON_USEDEP}]
	selinux? ( sec-policy/selinux-certbot )
"

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
distutils_enable_tests pytest
