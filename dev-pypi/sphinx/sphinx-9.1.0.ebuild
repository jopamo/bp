# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="sphinx"
DESCRIPTION="Python documentation generator"
HOMEPAGE="https://www.sphinx-doc.org/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/alabaster
	dev-pypi/babel
	dev-pypi/docutils
	dev-pypi/imagesize
	dev-pypi/jinja2
	dev-pypi/packaging
	dev-pypi/pygments
	dev-pypi/requests
	dev-pypi/roman-numerals
	dev-pypi/snowballstemmer
	dev-pypi/sphinxcontrib-applehelp
	dev-pypi/sphinxcontrib-devhelp
	dev-pypi/sphinxcontrib-htmlhelp
	dev-pypi/sphinxcontrib-jsmath
	dev-pypi/sphinxcontrib-qthelp
	dev-pypi/sphinxcontrib-serializinghtml
"
# lockstep-pypi-deps: end
