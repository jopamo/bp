# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="The build backend used by PDM that supports latest packaging standards"
HOMEPAGE="https://github.com/pdm-project/pdm-backend"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/e2/38/d22c1050130b8cdf16fef76c99c59968086802744947f2813d45c69cca52/pdm_backend-2.4.7.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pdm_backend-2.4.7"
