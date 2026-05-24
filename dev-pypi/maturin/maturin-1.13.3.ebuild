# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1 pypi

DESCRIPTION="Build and publish crates with pyo3, cffi and uniffi bindings as well as rust binaries as python packages"
HOMEPAGE="https://github.com/pyo3/maturin"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="maturin"

BDEPEND="
	dev-py/setuptools-rust[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
