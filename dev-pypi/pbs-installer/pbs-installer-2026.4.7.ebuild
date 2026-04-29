# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1

DESCRIPTION="Installer for Python Build Standalone"
HOMEPAGE="https://pypi.org/project/pbs-installer/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b0/3b/a44eaea135e214d7095a0037c1fc43e71094e4946d63b4fd208f97f5e28c/pbs_installer-2026.4.7.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pbs_installer-2026.4.7"
