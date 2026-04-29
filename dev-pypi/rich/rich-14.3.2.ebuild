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

SRC_URI="https://files.pythonhosted.org/packages/74/99/a4cab2acbb884f80e558b0771e97e21e939c5dfb460f488d19df485e8298/rich-14.3.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rich-14.3.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/markdown-it-py
	dev-pypi/pygments
"
# lockstep-pypi-deps: end
