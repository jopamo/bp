# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Pygments is a syntax highlighting package written in Python."
HOMEPAGE="https://pygments.org"
LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pygments-2.19.2"
