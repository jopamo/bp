# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

MY_PN=ConfigArgParse
MY_P=${MY_PN}-${PV}

DESCRIPTION="Drop-in replacement for argparse supporting config files and env variables"
HOMEPAGE="https://github.com/zorro3/ConfigArgParse https://pypi.org/project/ConfigArgParse/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

S=${WORKDIR}/${MY_P}

RESTRICT="test"

python_test() {
	${PYTHON} tests/test_configargparse.py || die
}
