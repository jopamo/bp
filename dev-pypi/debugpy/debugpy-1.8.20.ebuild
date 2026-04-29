# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="An implementation of the Debug Adapter Protocol for Python"
HOMEPAGE="https://aka.ms/debugpy"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/e0/b7/cd8080344452e4874aae67c40d8940e2b4d47b01601a8fd9f44786c757c7/debugpy-1.8.20.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/debugpy-1.8.20"
