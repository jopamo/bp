# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DISTUTILS_USE_PEP517=standalone

DESCRIPTION="pkgcore-based QA utility for ebuild repos"
HOMEPAGE="https://github.com/pkgcore/pkgcheck"

SNAPSHOT=b67acd43a296495f50bc6ce147ac45490ad6bc87
SRC_URI="https://github.com/pkgcore/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-py/snakeoil-0.10.7[${PYTHON_USEDEP}]
	>=app-core/pkgcore-0.12.25[${PYTHON_USEDEP}]
	>=lib-dev/tree-sitter-bash-0.21.0[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/lazy-object-proxy[${PYTHON_USEDEP}]
	dev-py/lxml[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	>=dev-py/tree-sitter-0.21.0[${PYTHON_USEDEP}]
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
