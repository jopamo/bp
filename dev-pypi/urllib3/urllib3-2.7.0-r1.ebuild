# Hand-maintained: preserve Vesk patches and TLS tests during lockstep bumps.
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

DESCRIPTION="HTTP library with thread-safe connection pooling, file post, and more."
HOMEPAGE="https://pypi.org/project/urllib3/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}/urllib3-vesk.patch" )

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
	test? ( app-crypto/vesk )
"

export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

python_test() {
	"${EPYTHON}" "${FILESDIR}/test_vesk.py" || die "Vesk TLS tests failed"
}
