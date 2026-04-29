# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Small library to dynamically create python functions."
HOMEPAGE="https://github.com/smarie/python-makefun"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/7b/cf/6780ab8bc3b84a1cce3e4400aed3d64b6db7d5e227a2f75b6ded5674701a/makefun-1.16.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/makefun-1.16.0"
