# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Pexpect allows easy control of interactive console applications."
HOMEPAGE="https://pexpect.readthedocs.io/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/42/92/cc564bf6381ff43ce1f4d06852fc19a2f11d180f23dc32d9588bee2f149d/pexpect-4.9.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pexpect-4.9.0"
