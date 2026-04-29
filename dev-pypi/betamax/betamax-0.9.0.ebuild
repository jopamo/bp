# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A VCR imitation for python-requests"
HOMEPAGE="https://github.com/sigmavirus24/betamax"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c2/a2/b5a47f7c57ef30337503bf7ea959e498a314018eb74dd833d4bd4a689e03/betamax-0.9.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/betamax-0.9.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/requests
"
# lockstep-pypi-deps: end
