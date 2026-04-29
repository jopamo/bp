# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Read/rewrite/write Python ASTs"
HOMEPAGE="https://github.com/berkerpeksag/astor"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5a/21/75b771132fee241dfe601d39ade629548a9626d1d39f333fde31bc46febe/astor-0.8.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/astor-0.8.1"
