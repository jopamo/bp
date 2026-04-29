# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Python port of markdown-it. Markdown parsing, done right!"
HOMEPAGE="https://github.com/executablebooks/markdown-it-py"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/markdown_it_py-4.0.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/mdurl
"
# lockstep-pypi-deps: end
