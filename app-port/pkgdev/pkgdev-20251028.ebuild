# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1

DESCRIPTION="Collection of tools for Gentoo development"
HOMEPAGE="https://github.com/pkgcore/pkgdev"
SNAPSHOT=f1e580aa96256cc3aadb555a3e811804b1c153cb
SRC_URI="https://github.com/pkgcore/pkgdev/archive/${SNAPSHOT}.tar.gz -> pkgdev-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pkgdev-${SNAPSHOT}"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# https://github.com/pkgcore/pkgdev/blob/main/requirements/install.txt
RDEPEND="
	>=dev-py/snakeoil-0.9.6[${PYTHON_USEDEP}]
	>=app-port/pkgcheck-0.10.0[${PYTHON_USEDEP}]
	>=app-core/pkgcore-0.12.0[${PYTHON_USEDEP}]
"

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
