# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="stable-$(ver_cut 1-2)"

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end
DESCRIPTION="a radically simple IT automation platform"
HOMEPAGE="https://ansible.com/"
SNAPSHOT=56ded14dd48e86168eb31d93898117086ba44186
SRC_URI="https://github.com/ansible/ansible/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ansible-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

RDEPEND="
	dev-pypi/paramiko[${PYTHON_USEDEP}]
	>=dev-pypi/jinja-3.1.0[${PYTHON_USEDEP}]
	>=dev-pypi/pyyaml-5.1[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	app-crypto/cryptography[${PYTHON_USEDEP}]
	dev-pypi/httplib2[${PYTHON_USEDEP}]
	dev-pypi/six[${PYTHON_USEDEP}]
	dev-pypi/packaging[${PYTHON_USEDEP}]
	>=dev-pypi/resolvelib-0.8.0[${PYTHON_USEDEP}]
	<dev-pypi/resolvelib-2.0.0[${PYTHON_USEDEP}]
"
DEPEND="
	>=dev-pypi/setuptools-77.0.3[${PYTHON_USEDEP}]
	<=dev-pypi/setuptools-84.0.0[${PYTHON_USEDEP}]
	>=dev-pypi/packaging-16.6[${PYTHON_USEDEP}]
"
