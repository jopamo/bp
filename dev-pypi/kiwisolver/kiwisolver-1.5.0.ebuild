# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A fast implementation of the Cassowary constraint solver"
HOMEPAGE="https://github.com/nucleic/kiwi"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d0/67/9c61eccb13f0bdca9307614e782fec49ffdde0f7a2314935d489fa93cd9c/kiwisolver-1.5.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/kiwisolver-1.5.0"
