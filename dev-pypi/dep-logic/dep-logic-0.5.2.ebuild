# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1

DESCRIPTION="Python dependency specifications supporting logical operations"
HOMEPAGE="https://pypi.org/project/dep-logic/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d8/00/93a90a4ce514e63a181486c6408ea50e8cdf7cdb73ab5580a6f7f5e5a496/dep_logic-0.5.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dep_logic-0.5.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
