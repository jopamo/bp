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

SRC_URI="https://files.pythonhosted.org/packages/04/af/88fdebf242bc7bc4957c96c5358a2b2b0f07e5001401906783a521ea9f54/trove_classifiers-2026.4.28.13.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trove_classifiers-2026.4.28.13"
