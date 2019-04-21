# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit distutils-r1

DESCRIPTION="a framework for package management"
HOMEPAGE="https://github.com/pkgcore/pkgcore"
LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
IUSE="doc test"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/pkgcore/pkgcore.git"
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=97936ef26f0ceaeeb545861d7f5be864ac78d3bf
	SRC_URI="https://github.com/pkgcore/pkgcore/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

DEPEND="dev-python/snakeoil[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare_all() {
	cp ${FILESDIR}/repos.conf ${S}/config/
	cp ${FILESDIR}/make.globals ${S}/config/

	distutils-r1_python_prepare_all
}

python_compile_all() {
	esetup.py build_man $(usex doc "build_docs" "")
}

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinst() {
	python_foreach_impl pplugincache
}
