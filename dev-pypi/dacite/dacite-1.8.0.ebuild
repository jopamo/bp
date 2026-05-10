# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Simple creation of data classes from dictionaries."
HOMEPAGE="https://github.com/konradhalas/dacite"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6f/6d/f7ee0f5410665cdfbd56d0caf5da9217410348e5a0c11d3e6cfe1c1ddd7a/dacite-1.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dacite-1.8.0"
