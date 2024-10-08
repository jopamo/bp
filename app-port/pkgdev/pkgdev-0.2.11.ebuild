# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1

DESCRIPTION="Collection of tools for Gentoo development"
HOMEPAGE="https://github.com/pkgcore/pkgdev"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

if [[ ${PV} == *9999 ]] ; then
	# https://github.com/pkgcore/pkgdev/blob/main/requirements/dev.txt
	RDEPEND="
		~dev-python/snakeoil-9999[${PYTHON_USEDEP}]
		~app-port/pkgcheck-9999[${PYTHON_USEDEP}]
		~app-core/pkgcore-9999[${PYTHON_USEDEP}]
	"
else
	# https://github.com/pkgcore/pkgdev/blob/main/requirements/install.txt
	RDEPEND="
		>=dev-python/snakeoil-0.9.6[${PYTHON_USEDEP}]
		>=app-port/pkgcheck-0.10.0[${PYTHON_USEDEP}]
		>=app-core/pkgcore-0.12.0[${PYTHON_USEDEP}]
	"
fi

# Uses pytest but we want to use the setup.py runner to get generated modules
BDEPEND+="test? ( dev-python/pytest )"
RDEPEND+="app-core/git"

distutils_enable_sphinx doc
distutils_enable_tests setup.py

python_compile_all() {
	# We'll generate man pages ourselves
	# Revisit when a release is made
	# to pregenerate them, making USE=doc
	# for generating the real HTML docs only.
	use doc && emake -C doc man

	# HTML pages only
	sphinx_compile_all
}

python_install_all() {
	use doc && doman doc/_build/man/*
	distutils-r1_python_install_all
}
