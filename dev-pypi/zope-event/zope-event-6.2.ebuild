# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Very basic event publishing system"
HOMEPAGE="https://pypi.org/project/zope-event/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/93/41/faa10af34d48d9cd6fa0249a1162943ad84a9590bd1a06939981e6640416/zope_event-6.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/zope_event-6.2"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
