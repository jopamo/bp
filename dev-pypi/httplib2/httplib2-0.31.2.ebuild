# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A comprehensive HTTP client library."
HOMEPAGE="https://github.com/httplib2/httplib2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c1/1f/e86365613582c027dda5ddb64e1010e57a3d53e99ab8a72093fa13d565ec/httplib2-0.31.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/httplib2-0.31.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pyparsing
"
# lockstep-pypi-deps: end
