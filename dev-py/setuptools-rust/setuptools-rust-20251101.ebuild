# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

DESCRIPTION="A plugin for setuptools to build Rust Python extensions"
HOMEPAGE="
	https://github.com/PyO3/setuptools-rust/
	https://pypi.org/project/setuptools-rust/
"
SNAPSHOT=5cd861c3bfc503ae2687f0fa343e7d545ba9bf44
SRC_URI="https://github.com/PyO3/setuptools-rust/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/setuptools-rust-${SNAPSHOT}

# crates are used at test time only, update via pycargoebuild -L -i ...
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	virtual/rust
	<dev-python/semantic-version-3[${PYTHON_USEDEP}]
	>=dev-python/semantic-version-2.8.2[${PYTHON_USEDEP}]
	>=dev-py/setuptools-62.4[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-py/setuptools-62.4[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-python/cffi[${PYTHON_USEDEP}]
		' 'python*')
		dev-py/lxml[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"
