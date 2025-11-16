# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="
	https://www.dnspython.org/
	https://github.com/rthalley/dnspython/
	https://pypi.org/project/dnspython/
"
SNAPSHOT=497263831a678aa573c34554bb843df1943f37b5
SRC_URI="https://github.com/rthalley/dnspython/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="dnssec examples"

RDEPEND="
	dnssec? (
		>=dev-python/cryptography-41[${PYTHON_USEDEP}]
	)
	>=dev-python/idna-2.1[${PYTHON_USEDEP}]
"
# note: skipping DoH test deps because they require Internet anyway
BDEPEND="
	test? (
		>=dev-python/cryptography-41[${PYTHON_USEDEP}]
		>=dev-python/quart-trio-0.11.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x NO_INTERNET=1
	epytest
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
