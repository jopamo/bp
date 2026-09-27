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

SRC_URI="https://files.pythonhosted.org/packages/82/14/1bafca9db7691ff05767570686cd775bddec57c7358e78504cbfd35ec996/meson_python-0.22.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/meson_python-0.22.0"

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
