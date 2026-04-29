# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pathable
	dev-pypi/pyyaml
	dev-pypi/referencing
"
# lockstep-pypi-deps: end
MY_P=${P/_beta/b}
DESCRIPTION="JSONSchema Spec with object-oriented paths"
HOMEPAGE="
	https://pypi.org/project/jsonschema-path/
	https://github.com/p1c2u/jsonschema-path/
"
SRC_URI="
	https://github.com/p1c2u/jsonschema-path/archive/${PV/_beta/b}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	>=dev-py/pathable-0.5.0_beta1[${PYTHON_USEDEP}]
	>=dev-py/pyrsistent-0.20.0[${PYTHON_USEDEP}]
	>=dev-pypi/pyyaml-5.1[${PYTHON_USEDEP}]
	>=dev-pypi/referencing-0.28.1[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-py/responses[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	sed -i -e '/--cov/d' pyproject.toml || die
	# remove random pins
	sed -i -e 's:\^:>=:' -e 's:<[0-9.]\+:*:' pyproject.toml || die
	distutils-r1_src_prepare
}
