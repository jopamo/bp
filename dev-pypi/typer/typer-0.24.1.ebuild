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

SRC_URI="https://files.pythonhosted.org/packages/f5/24/cb09efec5cc954f7f9b930bf8279447d24618bb6758d4f6adf2574c41780/typer-0.24.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/typer-0.24.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/annotated-doc
	dev-pypi/click
	dev-pypi/rich
	dev-pypi/shellingham
"
# lockstep-pypi-deps: end
