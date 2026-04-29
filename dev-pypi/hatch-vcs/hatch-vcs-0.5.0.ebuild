# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Hatch plugin for versioning with your preferred VCS"
HOMEPAGE="https://pypi.org/project/hatch-vcs/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6b/b0/4cc743d38adbee9d57d786fa496ed1daadb17e48589b6da8fa55717a0746/hatch_vcs-0.5.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hatch_vcs-0.5.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/hatchling
	dev-pypi/setuptools-scm
"
# lockstep-pypi-deps: end
