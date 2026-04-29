# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Simple VTXXX-compatible terminal emulator."
HOMEPAGE="https://github.com/selectel/pyte"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ab/ab/b599762933eba04de7dc5b31ae083112a6c9a9db15b01d3109ad797559d9/pyte-0.8.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pyte-0.8.2"
