# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Typing stubs for psutil"
HOMEPAGE="https://github.com/python/typeshed"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/70/cc/5ac56357b08655ff93106d6391b72d50c47416a044041312550bcd806827/types_psutil-7.2.2.20260508.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/types_psutil-7.2.2.20260508"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
