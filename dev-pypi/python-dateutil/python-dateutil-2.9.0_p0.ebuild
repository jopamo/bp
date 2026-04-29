# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Extensions to the standard Python datetime module"
HOMEPAGE="https://github.com/dateutil/dateutil"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/66/c0/0c8b6ad9f17a802ee498c46e004a0eb49bc148f2fd230864601a86dcf6db/python-dateutil-2.9.0.post0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python-dateutil-2.9.0.post0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/six
"
# lockstep-pypi-deps: end
