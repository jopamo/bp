# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="no"

inherit distutils-r1

DESCRIPTION="A library for installing Python wheels."
HOMEPAGE="https://pypi.org/project/installer/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/56/d3/2fab33d15004d41ae8e7b5d3e310510f7f34a7e1dd032a3e60d8b38d8fba/installer-1.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/installer-1.1.0"

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
"

python_compile() {
	"${EPYTHON}" -m flit_core.wheel --outdir "${BUILD_DIR}" || die
	local -x PYTHONPATH="${S}/src${PYTHONPATH:+:${PYTHONPATH}}"
	"${EPYTHON}" -m installer --destdir "${BUILD_DIR}/install" \
		--prefix "${EPREFIX}/usr" \
		--compile-bytecode 0 --compile-bytecode 1 --compile-bytecode 2 \
		"${BUILD_DIR}"/*.whl || die
}
