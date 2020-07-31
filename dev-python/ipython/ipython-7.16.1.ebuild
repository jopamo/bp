# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Advanced interactive shell for Python"
HOMEPAGE="http://ipython.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="matplotlib notebook nbconvert qt5 +smp test"

RESTRICT="!test? ( test )"

CDEPEND="
	dev-python/backcall[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/jedi[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/pickleshare[${PYTHON_USEDEP}]
	>=dev-python/prompt_toolkit-2[${PYTHON_USEDEP}]
	<dev-python/prompt_toolkit-2.1[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/traitlets[${PYTHON_USEDEP}]
	matplotlib? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
"

RDEPEND="${CDEPEND}
	nbconvert? ( dev-python/nbconvert[${PYTHON_USEDEP}] )"

DEPEND="${CDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		>=dev-python/ipykernel-5.1.0[${PYTHON_USEDEP}]
		dev-python/nbformat[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/testpath[${PYTHON_USEDEP}]
	)"

PDEPEND="
	notebook? (
		dev-python/notebook[${PYTHON_USEDEP}]
		dev-python/ipywidgets[${PYTHON_USEDEP}]
		dev-python/widgetsnbextension[${PYTHON_USEDEP}]
	)
	qt5? ( dev-python/qtconsole[${PYTHON_USEDEP}] )
	smp? (
		>=dev-python/ipykernel-5.1.0[${PYTHON_USEDEP}]
		>=dev-python/ipyparallel-6.2.3[${PYTHON_USEDEP}]
	)"

PATCHES=( "${FILESDIR}"/2.1.0-substitute-files.patch )

DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	# Remove out of date insource files
	rm IPython/extensions/cythonmagic.py || die
	rm IPython/extensions/rmagic.py || die

	distutils-r1_python_prepare_all
}

src_test() {
	virtx distutils-r1_src_test
}

python_test() {
	distutils_install_for_testing
	pushd "${TEST_DIR}" >/dev/null || die
	"${TEST_DIR}"/scripts/iptest || die
	popd >/dev/null || die
}

python_install() {
	distutils-r1_python_install

	# Create ipythonX.Y symlinks.
	# TODO:
	# 1. do we want them for pypy? No.  pypy has no numpy
	# 2. handle it in the eclass instead (use _python_ln_rel).
	# With pypy not an option the dosym becomes unconditional
	dosym ../lib/python-exec/${EPYTHON}/ipython \
		/usr/bin/ipython${EPYTHON#python}
}

pkg_postinst() {
	optfeature "sympyprinting" dev-python/sympy
	optfeature "cythonmagic" dev-python/cython
	optfeature "%lprun magic command" dev-python/line_profiler
	optfeature "%mprun magic command" dev-python/memory_profiler

	if use nbconvert; then
		if ! has_version app-text/pandoc ; then
			einfo "Node.js will be used to convert notebooks to other formats"
			einfo "like HTML. Support for that is still experimental. If you"
			einfo "encounter any problems, please use app-text/pandoc instead."
		fi
	fi
}
