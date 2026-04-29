# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="miscellaneous path functions"
HOMEPAGE="https://pypi.org/project/jaraco-path/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/0a/b4/05c65ee5637d8156863bb34340cb41f6bd316a019b39ae64632502eb5cfa/jaraco_path-3.7.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jaraco_path-3.7.2"
