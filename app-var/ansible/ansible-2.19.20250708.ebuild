# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="stable-$(ver_cut 1-2)"

inherit distutils-r1

DESCRIPTION="a radically simple IT automation platform"
HOMEPAGE="https://ansible.com/"
SNAPSHOT=66eb3e75895f37ee8f497e3cc567bcfdb7e45120
SRC_URI="https://github.com/ansible/ansible/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ansible-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

RDEPEND="
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-py/jinja[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-py/setuptools[${PYTHON_USEDEP}]
	app-crypto/cryptography[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="
	dev-py/setuptools[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.6[${PYTHON_USEDEP}]
"
