# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="File-system specification"
HOMEPAGE="https://github.com/fsspec/filesystem_spec"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/51/7c/f60c259dcbf4f0c47cc4ddb8f7720d2dcdc8888c8e5ad84c73ea4531cc5b/fsspec-2026.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fsspec-2026.2.0"
