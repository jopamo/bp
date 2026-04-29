# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Backport of pathlib-compatible object wrapper for zip files"
HOMEPAGE="https://pypi.org/project/zipp/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/30/21/093488dfc7cc8964ded15ab726fad40f25fd3d788fd741cc1c5a17d78ee8/zipp-3.23.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/zipp-3.23.1"
