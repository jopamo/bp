# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A schema and validator for YAML."
HOMEPAGE="https://github.com/23andMe/Yamale"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c6/a6/6bfdf3b84fe2db12e2fe900f9ab89b2a42f99764722c0f1174e99340b0bf/yamale-5.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/yamale-5.3.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pyyaml
"
# lockstep-pypi-deps: end
