# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Safely evaluate AST nodes without side effects"
HOMEPAGE="http://github.com/alexmojaki/pure_eval"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/cd/05/0a34433a064256a578f1783a10da6df098ceaa4a57bbeaa96a6c0352786b/pure_eval-0.2.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pure_eval-0.2.3"
