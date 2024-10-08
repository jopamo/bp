# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DISTUTILS_USE_PEP517=standalone

DESCRIPTION="pkgcore-based QA utility for ebuild repos"
HOMEPAGE="https://github.com/pkgcore/pkgcheck"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/pkgcore/pkgcheck.git"
	inherit git-r3
else
	KEYWORDS="amd64 arm64"
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
fi

LICENSE="BSD MIT"
SLOT="0"

if [[ ${PV} == *9999 ]]; then
	RDEPEND="
		~dev-python/snakeoil-9999[${PYTHON_USEDEP}]
		~sys-apps/pkgcore-9999[${PYTHON_USEDEP}]"
else
	RDEPEND="
		>=dev-python/snakeoil-0.10.7[${PYTHON_USEDEP}]
		>=app-core/pkgcore-0.12.25[${PYTHON_USEDEP}]"
fi
RDEPEND+="
	>=lib-dev/tree-sitter-bash-0.21.0[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/lazy-object-proxy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-0.21.0[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}
	>=dev-python/flit-core-3.8[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests setup.py

export USE_SYSTEM_TREE_SITTER_BASH=1
