# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Plumbum: shell combinators library"
HOMEPAGE="https://github.com/tomerfiliba/plumbum"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6c/d2/578712a979a50e9aba08ea173a38e7598461130d3c9899f176373bc03280/plumbum-2.0.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/plumbum-2.0.2"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"

export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
