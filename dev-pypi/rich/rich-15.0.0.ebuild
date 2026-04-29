# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal"
HOMEPAGE="https://github.com/Textualize/rich"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rich-15.0.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/markdown-it-py
	dev-pypi/pygments
"
# lockstep-pypi-deps: end
