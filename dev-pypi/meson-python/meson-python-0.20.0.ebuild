# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Meson Python build backend (PEP 517)"
HOMEPAGE="https://github.com/mesonbuild/meson-python"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/8b/f0/d794d7ed8a843a8a8947768f3b329d1e8601222dc95d930f4a5f9706cd6c/meson_python-0.20.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/meson_python-0.20.0"

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
