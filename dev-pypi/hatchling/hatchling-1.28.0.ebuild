# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Modern, extensible Python build backend"
HOMEPAGE="https://hatch.pypa.io/latest/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/0b/8e/e480359492affde4119a131da729dd26da742c2c9b604dff74836e47eef9/hatchling-1.28.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hatchling-1.28.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/pathspec
	dev-pypi/pluggy
	dev-pypi/trove-classifiers
"
# lockstep-pypi-deps: end
