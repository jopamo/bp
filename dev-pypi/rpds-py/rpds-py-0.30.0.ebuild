# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="Python bindings to Rust's persistent data structures (rpds)"
HOMEPAGE="https://github.com/crate-py/rpds"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/20/af/3f2f423103f1113b36230496629986e0ef7e199d2aa8392452b484b38ced/rpds_py-0.30.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rpds_py-0.30.0"
