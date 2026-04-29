# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="rich-rst"
DESCRIPTION="A beautiful reStructuredText renderer for rich"
HOMEPAGE="https://wasi-master.github.io/rich-rst"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/docutils
	dev-pypi/rich
"
# lockstep-pypi-deps: end
