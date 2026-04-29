# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Backport of CPython tarfile module"
HOMEPAGE="https://github.com/jaraco/backports.tarfile"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/86/72/cd9b395f25e290e633655a100af28cb253e4393396264a98bd5f5951d50f/backports_tarfile-1.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/backports_tarfile-1.2.0"
