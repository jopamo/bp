# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="An implementation of the ACME protocol"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="https://github.com/certbot/certbot.git"
	inherit git-r3
	S=${WORKDIR}/${P}/${PN}
else
	SRC_URI="https://github.com/certbot/certbot/archive/v${PV}.tar.gz -> certbot-${PV}.tar.gz"
	KEYWORDS="amd64 arm64"
	S=${WORKDIR}/certbot-${PV}/${PN}
fi

LICENSE="Apache-2.0"
SLOT="0"

IUSE="test"

RDEPEND="
	>=dev-python/cryptography-0.8[${PYTHON_USEDEP}]
	>=dev-python/josepy-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.13[${PYTHON_USEDEP}]
	dev-python/pyrfc3339[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	>=dev-python/requests-2.10[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
	>=dev-python/setuptools-1.0[${PYTHON_USEDEP}]
"

python_test() {
	nosetests -w ${PN} || die
}
