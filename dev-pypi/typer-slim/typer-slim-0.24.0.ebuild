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

SRC_URI="https://files.pythonhosted.org/packages/a7/a7/e6aecc4b4eb59598829a3b5076a93aff291b4fdaa2ded25efc4e1f4d219c/typer_slim-0.24.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/typer_slim-0.24.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typer
"
# lockstep-pypi-deps: end
