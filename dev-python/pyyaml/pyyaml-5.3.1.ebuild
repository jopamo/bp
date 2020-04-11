# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

MY_P="PyYAML-${PV}"

DESCRIPTION="YAML parser and emitter for Python"
HOMEPAGE="https://pyyaml.org/wiki/PyYAML https://pypi.org/project/PyYAML/"
SRC_URI="https://pyyaml.org/download/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

S="${WORKDIR}/${MY_P}"

python_test() {
	esetup.py test
}
