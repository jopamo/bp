# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="HTTP library with thread-safe connection pooling, file post, and more."
HOMEPAGE="https://pypi.org/project/urllib3/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/53/0c/06f8b233b8fd13b9e5ee11424ef85419ba0d8ba0b3138bf360be2ff56953/urllib3-2.7.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/urllib3-2.7.0"

BDEPEND="
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
"
