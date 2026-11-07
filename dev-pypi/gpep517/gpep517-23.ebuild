# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="no"

inherit distutils-r1

DESCRIPTION="Python package builder and installer for non-pip-centric world"
HOMEPAGE="https://pypi.org/project/gpep517/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6b/c7/0db99e2a001e2a7cc1a01b67b276d3a233e0a791122f84e618739929a07c/gpep517-23.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gpep517-23"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/installer
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/installer[${PYTHON_USEDEP}]
	dev-pypi/flit-core[${PYTHON_USEDEP}]
"

python_compile() {
	"${EPYTHON}" -m flit_core.wheel --outdir "${BUILD_DIR}" || die
	"${EPYTHON}" -m installer --destdir "${BUILD_DIR}/install" \
		--prefix "${EPREFIX}/usr" \
		--compile-bytecode 0 --compile-bytecode 1 --compile-bytecode 2 \
		"${BUILD_DIR}"/*.whl || die
}
