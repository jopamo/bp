# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Helper to test command-line scripts"
HOMEPAGE="https://scripttest.readthedocs.io/en/stable/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6b/75/40225296f18bcd24c95258f3a01fce7e4a014b67141209846d794c3bb694/scripttest-2.0.post1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/scripttest-2.0.post1"
