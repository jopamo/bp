# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="License management tooling for Coherent System and skeleton projects"
HOMEPAGE="https://pypi.org/project/coherent-licensed/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/cd/e9/63d2dcccb5496cc99d96f29a8a5f3e2c6ed0bba7fedb840862f92816ee17/coherent_licensed-0.5.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/coherent_licensed-0.5.2"

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
"
