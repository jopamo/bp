# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 flag-o-matic git-r3

DESCRIPTION="Library providing cryptographic recipes and primitives"
HOMEPAGE="https://github.com/jopamo/cryptography"
EGIT_REPO_URI="https://github.com/jopamo/cryptography"

LICENSE="|| ( Apache-2.0 BSD ) PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	virtual/ssl
	>=dev-python/cffi-1.12[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	dev-py/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hypothesis-1.11.4[${PYTHON_USEDEP}]
		dev-python/iso8601[${PYTHON_USEDEP}]
		dev-python/pretend[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	filter-flags -flto*

	default
}

python_test() {
	local -x PYTHONPATH="${PYTHONPATH}:${S}/vectors"

	epytest
}

python_install() {
	distutils-r1_python_install

	# cryptography wheels can drop stray top-level files into site-packages
	local spdir
	spdir="$(python_get_sitedir)" || die

	rm -f "${ED}${spdir}/CHANGELOG.rst" \
		"${ED}${spdir}/CONTRIBUTING.rst" || die
	rm -rf "${ED}${spdir}/tests" || die
}

python_install_all() {
	distutils-r1_python_install_all

	dodoc CHANGELOG.rst CONTRIBUTING.rst
}
