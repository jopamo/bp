# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Model-driven deployment, config management, and command execution framework"
HOMEPAGE="https://ansible.com/"
SRC_URI="https://releases.ansible.com/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="test"

RDEPEND="
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.6[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		dev-python/passlib[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/unittest2[${PYTHON_USEDEP}]
		dev-vcs/git
	)"

python_prepare_all() {
	rm -fv MANIFEST.in || die
	distutils-r1_python_prepare_all
}

python_test() {
	nosetests -d -w test/units -v --with-coverage --cover-package=ansible --cover-branches || die
}
