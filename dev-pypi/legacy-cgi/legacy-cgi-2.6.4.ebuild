# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Fork of the standard library cgi and cgitb modules removed in Python 3.13"
HOMEPAGE="https://pypi.org/project/legacy-cgi/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f4/9c/91c7d2c5ebbdf0a1a510bfa0ddeaa2fbb5b78677df5ac0a0aa51cf7125b0/legacy_cgi-2.6.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/legacy_cgi-2.6.4"
