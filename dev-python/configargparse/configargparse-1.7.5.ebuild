# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end

DESCRIPTION="Drop-in replacement for argparse supporting config files and env variables"
HOMEPAGE="
	https://github.com/bw2/ConfigArgParse/
	https://pypi.org/project/ConfigArgParse/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

src_test() {
	local -x COLUMNS=80
	distutils-r1_src_test
}
