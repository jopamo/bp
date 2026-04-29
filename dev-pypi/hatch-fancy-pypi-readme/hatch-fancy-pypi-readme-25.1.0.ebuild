# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Fancy PyPI READMEs with Hatch"
HOMEPAGE="https://pypi.org/project/hatch-fancy-pypi-readme/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f3/0f/aed57c301f339936eb91cb4d8c1e5088a101081854bd3ec18a889df32365/hatch_fancy_pypi_readme-25.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hatch_fancy_pypi_readme-25.1.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/hatchling
"
# lockstep-pypi-deps: end
