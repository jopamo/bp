# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Library for building powerful interactive command lines in Python"
HOMEPAGE="https://github.com/prompt-toolkit/python-prompt-toolkit"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a1/96/06e01a7b38dce6fe1db213e061a4602dd6032a8a97ef6c1a862537732421/prompt_toolkit-3.0.52.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/prompt_toolkit-3.0.52"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/wcwidth
"
# lockstep-pypi-deps: end
