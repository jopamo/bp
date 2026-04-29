# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A library for installing Python wheels."
HOMEPAGE="https://pypi.org/project/installer/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/05/18/ceeb4e3ab3aa54495775775b38ae42b10a92f42ce42dfa44da684289b8c8/installer-0.7.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/installer-0.7.0"
