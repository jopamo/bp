# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="AR file handling"
HOMEPAGE="https://github.com/getninjas/unix_ar"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/3e/37/65cb206bd7110887248fe041e00e61124abdcd23de8f19418898a51363fc/unix_ar-0.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/unix_ar-0.2.1"
