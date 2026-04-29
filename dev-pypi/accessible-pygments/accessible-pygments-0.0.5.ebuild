# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="A collection of accessible pygments styles"
HOMEPAGE="https://github.com/Quansight-Labs/accessible-pygments"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/bc/c1/bbac6a50d02774f91572938964c582fff4270eee73ab822a4aeea4d8b11b/accessible_pygments-0.0.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/accessible_pygments-0.0.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pygments
"
# lockstep-pypi-deps: end
