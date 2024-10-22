# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 doins

DESCRIPTION="Open source build system"
HOMEPAGE="http://mesonbuild.com/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/mesonbuild/meson"
	inherit git-r3
else
	SRC_URI="https://github.com/mesonbuild/meson/releases/download/${PV}/${P}.tar.gz"
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="vim zsh"

RESTRICT="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	${EPYTHON} run_tests.py || die
}

python_install_all() {
	distutils-r1_python_install_all

	if use vim ; then
		insinto /usr/share/vim/vimfiles
		doins data/syntax-highlighting/vim/{ftdetect,indent,syntax}
	fi

	if use zsh ; then
		insinto /usr/share/zsh/site-functions
		doins data/shell-completions/zsh/_meson
	fi

	dobashcomp data/shell-completions/bash/meson

	#lazy update mtime
	find "${ED}"/usr/share -type f -exec touch {} +

	python_doscript "${FILESDIR}"/meson-format-array
}
