# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Plumbum: shell combinators library"
HOMEPAGE="https://github.com/tomerfiliba/plumbum"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/dc/c8/11a5f792704b70f071a3dbc329105a98e9cc8d25daaf09f733c44eb0ef8e/plumbum-1.10.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/plumbum-1.10.0"
