# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Typing stubs for setuptools"
HOMEPAGE="https://github.com/python/typeshed"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a3/53/8c7ca2263165f13b493f5258a317acb09cab02742e816c38cd5fe6f09e5a/types_setuptools-82.0.0.20260508.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/types_setuptools-82.0.0.20260508"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
