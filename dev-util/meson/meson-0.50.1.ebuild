# Distributed under the terms of the GNU General Public License v2

EAPI=7


if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/mesonbuild/meson"
	inherit git-r3
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="amd64 arm64"
fi

inherit distutils-r1

DESCRIPTION="Open source build system"
HOMEPAGE="http://mesonbuild.com/"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	${EPYTHON} run_tests.py || die
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /usr/share/vim/vimfiles
	doins -r data/syntax-highlighting/vim/{ftdetect,indent,syntax}

	rm -rf "${ED}"/usr/share/polkit-1
}
