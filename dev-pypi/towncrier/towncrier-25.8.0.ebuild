# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Building newsfiles for your project."
HOMEPAGE="https://pypi.org/project/towncrier/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c2/eb/5bf25a34123698d3bbab39c5bc5375f8f8bcbcc5a136964ade66935b8b9d/towncrier-25.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/towncrier-25.8.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/click
	dev-pypi/jinja2
"
# lockstep-pypi-deps: end
