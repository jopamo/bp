# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Module for text manipulation"
HOMEPAGE="https://pypi.org/project/jaraco-text/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f2/20/f071dfb40f06fd0395167a40218c10adb7164635f65ebdafe45e0c714935/jaraco_text-4.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jaraco_text-4.2.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jaraco-context
	dev-pypi/jaraco-functools
	dev-pypi/more-itertools
	dev-pypi/typer-slim
"
# lockstep-pypi-deps: end
