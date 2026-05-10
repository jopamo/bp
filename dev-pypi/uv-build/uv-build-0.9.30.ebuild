# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="An extremely fast Python package and project manager, written in Rust."
HOMEPAGE="https://pypi.org/project/uv/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/4e/a0/63cea38fe839fb89592728b91928ee6d15705f1376a7940fee5bbc77fea0/uv-0.9.30.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uv-0.9.30"

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
"
