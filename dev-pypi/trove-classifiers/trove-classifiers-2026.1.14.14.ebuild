# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Canonical source for classifiers on PyPI (pypi.org)."
HOMEPAGE="https://github.com/pypa/trove-classifiers"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d8/43/7935f8ea93fcb6680bc10a6fdbf534075c198eeead59150dd5ed68449642/trove_classifiers-2026.1.14.14.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trove_classifiers-2026.1.14.14"
