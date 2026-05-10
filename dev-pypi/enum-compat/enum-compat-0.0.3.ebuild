# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="enum/enum34 compatibility package"
HOMEPAGE="https://github.com/jstasiak/enum-compat"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/41/46/8ed2368976d934652d8f33f1fdd86f5580fab45e890c90a848e83097a093/enum-compat-0.0.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/enum-compat-0.0.3"
