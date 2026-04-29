# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )
PYTHON_REQ_USE='sqlite'

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/fastjsonschema
	dev-pypi/jsonschema
	dev-pypi/jupyter-core
	dev-pypi/traitlets
"
# lockstep-pypi-deps: end
DESCRIPTION="Reference implementation of the Jupyter Notebook format"
HOMEPAGE="
	https://jupyter.org/
	https://github.com/jupyter/nbformat/
	https://pypi.org/project/nbformat/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-pypi/fastjsonschema-2.15[${PYTHON_USEDEP}]
	>=dev-pypi/jsonschema-2.6[${PYTHON_USEDEP}]
	>=dev-py/jupyter-core-5.1[${PYTHON_USEDEP}]
	>=dev-pypi/traitlets-5.1[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-py/hatch-nodejs-version[${PYTHON_USEDEP}]
	test? (
		dev-pypi/testpath[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs \
	dev-py/myst-parser \
	dev-py/pydata-sphinx-theme \
	dev-py/sphinxcontrib-github-alt \
	dev-py/sphinxcontrib-spelling
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# requires pep440 package, which is not really relevant for us
	tests/test_api.py
)
