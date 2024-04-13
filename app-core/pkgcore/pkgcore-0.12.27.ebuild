# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/pkgcore/pkgcore.git"
	inherit git-r3
else
	KEYWORDS="amd64 arm64"
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
fi

DESCRIPTION="a framework for package management"
HOMEPAGE="https://github.com/pkgcore/pkgcore"

LICENSE="BSD MIT"
SLOT="0"

RDEPEND="
	app-core/bash
	dev-python/lxml[${PYTHON_USEDEP}]"
if [[ ${PV} == *9999 ]]; then
	RDEPEND+=" ~dev-python/snakeoil-9999[${PYTHON_USEDEP}]"
else
	RDEPEND+=" >=dev-python/snakeoil-0.9.10[${PYTHON_USEDEP}]"
fi
BDEPEND="
	test? (
		>=dev-python/pytest-6[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_install_all() {
	local DOCS=( NEWS.rst )
	doman build/sphinx/man/*
	distutils-r1_python_install_all
}
