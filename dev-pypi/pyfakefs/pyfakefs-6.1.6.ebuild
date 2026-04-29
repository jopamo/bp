# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Implements a fake file system that mocks the Python file system modules."
HOMEPAGE="https://github.com/pytest-dev/pyfakefs"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/29/50/6aaa18de5e3c1b3ec73e4e9ed7ffa6972780972821ec65ace09e326c92b5/pyfakefs-6.1.6.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pyfakefs-6.1.6"
