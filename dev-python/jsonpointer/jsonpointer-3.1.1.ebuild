# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Identify specific nodes in a JSON document (according to draft 08)"
HOMEPAGE="
	https://github.com/stefankoegl/python-json-pointer/
	https://pypi.org/project/jsonpointer/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

python_test() {
	"${EPYTHON}" tests.py || die "Tests fail with ${EPYTHON}"
}
