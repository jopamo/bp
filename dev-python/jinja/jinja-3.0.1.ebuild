# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="A full-featured template engine for Python"
HOMEPAGE="http://jinja.pocoo.org/ https://pypi.python.org/pypi/Jinja2"
SRC_URI="https://github.com/pallets/jinja/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

wrap_opts() {
	local mydistutilsargs=()

	if [[ ${EPYTHON} == python* ]]; then
		mydistutilargs+=( --with-debugsupport )
	fi

	"${@}"
}

python_compile() {
	wrap_opts distutils-r1_python_compile
}

python_test() {
	py.test || die
}
