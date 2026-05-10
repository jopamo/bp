# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Keystone assembler engine"
HOMEPAGE="https://www.keystone-engine.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/0a/65/3a2e7e55cc1db188869bbbacee60036828330e0ce57fc5f05a3167ab4b4d/keystone-engine-0.9.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/keystone-engine-0.9.2"
