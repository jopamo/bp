# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="no"

inherit distutils-r1

DESCRIPTION="Distribution-building parts of Flit. See flit package for more information"
HOMEPAGE="https://pypi.org/project/flit-core/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d3/8b/0370578a456986d6995344967a479dd5c9d4e064681550c2a9594bb58b4a/flit_core-4.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/flit_core-4.2.0"

python_compile() {
	"${EPYTHON}" -m flit_core.wheel --outdir "${BUILD_DIR}" || die
	"${EPYTHON}" bootstrap_install.py \
		--installdir "${BUILD_DIR}/install$(python_get_sitedir)" \
		"${BUILD_DIR}"/flit_core-*.whl || die
	"${EPYTHON}" -m compileall -q -o 0 -o 1 -o 2 \
		-s "${BUILD_DIR}/install" -p / \
		"${BUILD_DIR}/install$(python_get_sitedir)" || die
}
