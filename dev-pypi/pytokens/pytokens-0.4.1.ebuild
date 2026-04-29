# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="pytokens"
DESCRIPTION="A Fast, spec compliant Python 3.14+ tokenizer that runs on older Pythons."
HOMEPAGE="https://github.com/tusharsadhwani/pytokens"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
