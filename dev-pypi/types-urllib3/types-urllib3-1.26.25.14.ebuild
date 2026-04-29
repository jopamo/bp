# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Typing stubs for urllib3"
HOMEPAGE="https://github.com/python/typeshed"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/73/de/b9d7a68ad39092368fb21dd6194b362b98a1daeea5dcfef5e1adb5031c7e/types-urllib3-1.26.25.14.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/types-urllib3-1.26.25.14"
