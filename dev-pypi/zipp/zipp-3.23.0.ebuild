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

SRC_URI="https://files.pythonhosted.org/packages/e3/02/0f2892c661036d50ede074e376733dca2ae7c6eb617489437771209d4180/zipp-3.23.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/zipp-3.23.0"
