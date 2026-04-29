# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1

DESCRIPTION="Typer, build great CLIs. Easy to code. Based on Python type hints."
HOMEPAGE="https://github.com/fastapi/typer"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/7b/27/ede8cec7596e0041ba7e7b80b47d132562f56ff454313a16f6084e555c9f/typer-0.25.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/typer-0.25.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/annotated-doc
	dev-pypi/click
	dev-pypi/rich
	dev-pypi/shellingham
"
# lockstep-pypi-deps: end
