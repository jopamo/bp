# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="referencing"
DESCRIPTION="JSON Referencing + Python"
HOMEPAGE="https://github.com/python-jsonschema/referencing"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/rpds-py
"
# lockstep-pypi-deps: end
