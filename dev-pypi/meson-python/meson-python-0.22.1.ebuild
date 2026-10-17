# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="The Python build backend for Meson projects"
HOMEPAGE="https://github.com/mesonbuild/meson-python"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b4/40/343ae23722d5d66a7b94b752d1b194202640995296379333b274b1860871/meson_python-0.22.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/meson_python-0.22.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	app-dev/meson
	dev-pypi/packaging
	dev-pypi/pyproject-metadata
"
# lockstep-pypi-deps: end

BDEPEND="
	app-dev/meson[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/packaging[${PYTHON_USEDEP}]
	dev-pypi/pyproject-metadata[${PYTHON_USEDEP}]
"
