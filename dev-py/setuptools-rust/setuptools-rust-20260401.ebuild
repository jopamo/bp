# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/semantic-version
	dev-pypi/setuptools
"
# lockstep-pypi-deps: end
DESCRIPTION="A plugin for setuptools to build Rust Python extensions"
HOMEPAGE="https://github.com/PyO3/setuptools-rust/"
SNAPSHOT=910fc604842ed37ed93aadbb5aef588af668d107
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
	<dev-py/semantic-version-3[${PYTHON_USEDEP}]
	>=dev-py/semantic-version-2.8.2[${PYTHON_USEDEP}]
	>=dev-py/setuptools-62.4[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-py/setuptools-62.4[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-py/beautifulsoup4[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-py/cffi[${PYTHON_USEDEP}]
		' 'python*')
		dev-py/lxml[${PYTHON_USEDEP}]
		dev-py/pytest[${PYTHON_USEDEP}]
	)
"
