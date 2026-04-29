# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Object-oriented paths"
HOMEPAGE="https://github.com/p1c2u/pathable"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/67/93/8f2c2075b180c12c1e9f6a09d1a985bc2036906b13dff1d8917e395f2048/pathable-0.4.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pathable-0.4.4"
