# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="markdown-it-py"
DESCRIPTION="Python port of markdown-it. Markdown parsing, done right!"
HOMEPAGE="https://github.com/executablebooks/markdown-it-py"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/mdurl
"
# lockstep-pypi-deps: end
