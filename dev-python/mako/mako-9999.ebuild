# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 git-r3

DESCRIPTION="A Python templating language"
HOMEPAGE="http://www.makotemplates.org/ https://pypi.python.org/pypi/Mako"
EGIT_REPO_URI="https://github.com/zzzeek/mako.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/markupsafe-0.9.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install_all() {
	rm -rf doc/build || die

	distutils-r1_python_install_all
}
