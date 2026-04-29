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

SRC_URI="https://files.pythonhosted.org/packages/5a/b6/3e681d3b6bb22647509bdbfdd18055d5adc0dce5c5585359fa46ff805fdc/typer-0.24.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/typer-0.24.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/annotated-doc
	dev-pypi/click
	dev-pypi/rich
	dev-pypi/shellingham
"
# lockstep-pypi-deps: end
