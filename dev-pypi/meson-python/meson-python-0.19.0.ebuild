# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1

DESCRIPTION="Meson Python build backend (PEP 517)"
HOMEPAGE="https://github.com/mesonbuild/meson-python"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/32/98/7fe5d1bf741c03c6eea04b6245737dbd79657d4f9200e82fcbb4cc12637b/meson_python-0.19.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/meson_python-0.19.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/meson
	dev-pypi/packaging
	dev-pypi/pyproject-metadata
"
# lockstep-pypi-deps: end
