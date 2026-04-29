# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1

DESCRIPTION="A library for working with the color formats defined by HTML and CSS."
HOMEPAGE="https://pypi.org/project/webcolors/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1d/7a/eb316761ec35664ea5174709a68bbd3389de60d4a1ebab8808bfc264ed67/webcolors-25.10.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/webcolors-25.10.0"
