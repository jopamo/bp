# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Static type checking support for Trio and related projects"
HOMEPAGE="https://github.com/python-trio/trio-typing"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b5/74/a87aafa40ec3a37089148b859892cbe2eef08d132c816d58a60459be5337/trio-typing-0.10.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trio-typing-0.10.0"
