# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

MY_P="PyYAML-${PV}"

DESCRIPTION="YAML parser and emitter for Python"
HOMEPAGE="https://pyyaml.org/wiki/PyYAML https://pypi.org/project/PyYAML/"
SRC_URI="https://pyyaml.org/download/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="libyaml"

RDEPEND="libyaml? ( dev-libs/libyaml )"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	# bug #659348
	"${FILESDIR}/${PN}-5.1-cve-2017-18342.patch"
)

python_configure_all() {
	mydistutilsargs=( $(use_with libyaml) )
}

python_test() {
	esetup.py test
}
