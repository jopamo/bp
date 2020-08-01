# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit distutils-r1 git-r3

DESCRIPTION="ADB shell functionality"
HOMEPAGE="https://github.com/JeffLIrion/adb_shell https://pypi.org/project/adb-shell/"
EGIT_REPO_URI="https://github.com/JeffLIrion/adb_shell"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
