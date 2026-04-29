# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A library for stubbing in Python"
HOMEPAGE="https://github.com/alex/pretend"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/3c/f8/7c86fd40c9e83deb10891a60d2dcb1af0b3b38064d72ebdb12486acc824f/pretend-1.0.9.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pretend-1.0.9"
