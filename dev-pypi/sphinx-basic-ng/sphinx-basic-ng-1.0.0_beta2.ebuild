# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A modern skeleton for Sphinx themes."
HOMEPAGE="https://github.com/pradyunsg/sphinx-basic-ng"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/98/0b/a866924ded68efec7a1759587a4e478aec7559d8165fac8b2ad1c0e774d6/sphinx_basic_ng-1.0.0b2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/sphinx_basic_ng-1.0.0b2"
