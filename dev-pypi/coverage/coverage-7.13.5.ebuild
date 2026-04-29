# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Code coverage measurement for Python"
HOMEPAGE="https://github.com/coveragepy/coveragepy"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/9d/e0/70553e3000e345daff267cec284ce4cbf3fc141b6da229ac52775b5428f1/coverage-7.13.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/coverage-7.13.5"
