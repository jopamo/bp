# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="stable-$(ver_cut 1-2)"

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="a radically simple IT automation platform"
HOMEPAGE="https://ansible.com/"
SNAPSHOT=9d07c13df93f37d2f1a1198610f63715cbb468b1
SRC_URI="https://github.com/ansible/ansible/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ansible-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

RDEPEND="
	dev-pypi/paramiko[${PYTHON_USEDEP}]
	dev-py/jinja[${PYTHON_USEDEP}]
	dev-pypi/pyyaml[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	app-crypto/cryptography[${PYTHON_USEDEP}]
	dev-pypi/httplib2[${PYTHON_USEDEP}]
	dev-pypi/six[${PYTHON_USEDEP}]
"
DEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	>=dev-pypi/packaging-16.6[${PYTHON_USEDEP}]
"
