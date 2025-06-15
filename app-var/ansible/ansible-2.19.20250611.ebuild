# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="stable-$(ver_cut 1-2)"

inherit distutils-r1

DESCRIPTION="a radically simple IT automation platform"
HOMEPAGE="https://ansible.com/"
SNAPSHOT=05951a6d9ada4e60e5985a62d62b00d9cb64bdea
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
