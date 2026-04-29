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
	>=dev-pypi/attrs-22.2.0[${PYTHON_USEDEP}]
	>=dev-pypi/jsonschema-specifications-2023.03.6[${PYTHON_USEDEP}]
	>=dev-pypi/referencing-0.28.4[${PYTHON_USEDEP}]
	>=dev-py/rpds-py-0.25.0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	dev-pypi/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	test? (
		dev-py/jsonpath-ng[${PYTHON_USEDEP}]
		!!dev-py/shiboken6
	)
"

# formatter deps
RDEPEND+="
	dev-pypi/fqdn[${PYTHON_USEDEP}]
	dev-pypi/idna[${PYTHON_USEDEP}]
	dev-pypi/isoduration[${PYTHON_USEDEP}]
	>=dev-pypi/jsonpointer-1.13[${PYTHON_USEDEP}]
	dev-pypi/rfc3339-validator[${PYTHON_USEDEP}]
	dev-pypi/rfc3986-validator[${PYTHON_USEDEP}]
	dev-pypi/rfc3987[${PYTHON_USEDEP}]
	dev-pypi/uri-template[${PYTHON_USEDEP}]
	>=dev-pypi/webcolors-24.6.0[${PYTHON_USEDEP}]
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
