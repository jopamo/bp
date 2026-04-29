# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Emoji for Python"
HOMEPAGE="https://github.com/carpedm20/emoji/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a2/78/0d2db9382c92a163d7095fc08efff7800880f830a152cfced40161e7638d/emoji-2.15.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/emoji-2.15.0"
