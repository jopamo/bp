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
SNAPSHOT=01c4f95c78031ba2db910dfc54efada1ed637455
SRC_URI="https://github.com/ansible/ansible/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ansible-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

RDEPEND="
	dev-py/paramiko[${PYTHON_USEDEP}]
	dev-py/jinja[${PYTHON_USEDEP}]
	dev-py/pyyaml[${PYTHON_USEDEP}]
	dev-py/setuptools[${PYTHON_USEDEP}]
	app-crypto/cryptography[${PYTHON_USEDEP}]
	dev-py/httplib2[${PYTHON_USEDEP}]
	dev-py/six[${PYTHON_USEDEP}]
"
DEPEND="
	dev-py/setuptools[${PYTHON_USEDEP}]
	>=dev-py/packaging-16.6[${PYTHON_USEDEP}]
"
