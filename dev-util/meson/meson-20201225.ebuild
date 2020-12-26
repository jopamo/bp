# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Open source build system"
HOMEPAGE="http://mesonbuild.com/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/mesonbuild/meson"
	inherit git-r3
else
	SNAPSHOT=2f836e3accd112a52bb8d3ef5d44b7e0fb692fcf
	SRC_URI="https://github.com/mesonbuild/meson/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

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

	#lazy update mtime
	find "${ED}"/usr/share -type f -exec touch {} +
}
