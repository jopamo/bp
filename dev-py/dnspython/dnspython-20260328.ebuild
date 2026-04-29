# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="https://www.dnspython.org/"
SNAPSHOT=f0dead006631c12a89cc4f15325d2d02b65379d8
SRC_URI="https://github.com/rthalley/dnspython/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="dnssec examples"

RDEPEND="
	dnssec? (
		>=dev-py/cryptography-41[${PYTHON_USEDEP}]
	)
	>=dev-pypi/idna-2.1[${PYTHON_USEDEP}]
"
# note: skipping DoH test deps because they require Internet anyway
BDEPEND="
	test? (
		>=dev-py/cryptography-41[${PYTHON_USEDEP}]
		>=dev-py/quart-trio-0.11.0[${PYTHON_USEDEP}]
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
