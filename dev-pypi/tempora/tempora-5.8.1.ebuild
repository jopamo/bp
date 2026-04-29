# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Objects and routines pertaining to date and time (tempora)"
HOMEPAGE="https://pypi.org/project/tempora/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/24/64/a255efe5edd367d12b770b3514194efdc1c97e5ed6ce6e8105d834750dfc/tempora-5.8.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tempora-5.8.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jaraco-functools
	dev-pypi/python-dateutil
"
# lockstep-pypi-deps: end
