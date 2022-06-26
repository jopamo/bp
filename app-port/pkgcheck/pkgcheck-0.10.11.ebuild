# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_IN_SOURCE_BUILD=1

inherit distutils-r1

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/pkgcore/pkgcheck.git"
	inherit git-r3
else
	KEYWORDS="amd64 arm64"
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
fi

DESCRIPTION="pkgcore-based QA utility for ebuild repos"
HOMEPAGE="https://github.com/pkgcore/pkgcheck"

LICENSE="BSD MIT"
SLOT="0"

if [[ ${PV} == *9999 ]]; then
	RDEPEND="
		~dev-python/snakeoil-9999[${PYTHON_USEDEP}]
		~app-core/pkgcore-9999[${PYTHON_USEDEP}]"
else
	RDEPEND="
		>=dev-python/snakeoil-0.9.10[${PYTHON_USEDEP}]
		>=app-core/pkgcore-0.12.11[${PYTHON_USEDEP}]"
fi
RDEPEND+="
	lib-dev/tree-sitter
	lib-dev/tree-sitter-bash
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/lazy-object-proxy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-0.19.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		app-core/git
	)
"

distutils_enable_tests setup.py

export USE_SYSTEM_TREE_SITTER_BASH=1

src_test() {
	local -x PYTHONDONTWRITEBYTECODE=
	distutils-r1_src_test
}

python_install_all() {
	local DOCS=( NEWS.rst )
	[[ ${PV} == *9999 ]] || doman man/*
	distutils-r1_python_install_all
}
