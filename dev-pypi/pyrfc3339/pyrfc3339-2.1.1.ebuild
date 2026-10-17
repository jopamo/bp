# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Generate and parse RFC 3339 timestamps"
HOMEPAGE="https://github.com/kurtraschke/pyrfc3339"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/80/7a/0e5227aa1c831fdaf579073a0ebb5ca11fc352a43fce8d2639e3ff87ff74/pyrfc3339-2.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pyrfc3339-2.1.1"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"

export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_PYRFC3339="${PV}"
