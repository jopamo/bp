# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO=https://github.com/python-jsonschema/jsonschema
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/jsonschema-specifications
	dev-pypi/referencing
	dev-pypi/rpds-py
"
# lockstep-pypi-deps: end
DESCRIPTION="An implementation of JSON-Schema validation for Python"
HOMEPAGE="
	https://pypi.org/project/jsonschema/
	https://github.com/python-jsonschema/jsonschema/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-py/attrs-22.2.0[${PYTHON_USEDEP}]
	>=dev-py/jsonschema-specifications-2023.03.6[${PYTHON_USEDEP}]
	>=dev-py/referencing-0.28.4[${PYTHON_USEDEP}]
	>=dev-py/rpds-py-0.25.0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-py/hatch-vcs[${PYTHON_USEDEP}]
	dev-py/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		dev-py/jsonpath-ng[${PYTHON_USEDEP}]
		!!dev-py/shiboken6
	)
"

# formatter deps
RDEPEND+="
	dev-py/fqdn[${PYTHON_USEDEP}]
	dev-py/idna[${PYTHON_USEDEP}]
	dev-py/isoduration[${PYTHON_USEDEP}]
	>=dev-py/jsonpointer-1.13[${PYTHON_USEDEP}]
	dev-py/rfc3339-validator[${PYTHON_USEDEP}]
	dev-py/rfc3986-validator[${PYTHON_USEDEP}]
	dev-py/rfc3987[${PYTHON_USEDEP}]
	dev-py/uri-template[${PYTHON_USEDEP}]
	>=dev-py/webcolors-24.6.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# requires pip, does not make much sense for the users
	jsonschema/tests/test_cli.py::TestCLIIntegration::test_license
	# fragile warning tests
	jsonschema/tests/test_deprecations.py
	# wtf?
	jsonschema/tests/test_jsonschema_test_suite.py::test_suite_bug
)
