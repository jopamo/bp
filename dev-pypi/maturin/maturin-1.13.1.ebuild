# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Build and publish crates with pyo3, cffi and uniffi bindings as well as rust binaries as python packages"
HOMEPAGE="https://github.com/pyo3/maturin"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/39/16/b284a7bc4af3dd87717c784278c1b8cb18606ad1f6f7a671c47bfd9c3df0/maturin-1.13.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/maturin-1.13.1"

BDEPEND="
	dev-py/setuptools-rust[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/tomli[${PYTHON_USEDEP}]
"
