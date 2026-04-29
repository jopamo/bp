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

SRC_URI="https://files.pythonhosted.org/packages/e1/cf/b50ddf667c15276a9ab15a70ef5f257564de271957933ffea49d2cdbcdfb/fsspec-2026.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fsspec-2026.3.0"
