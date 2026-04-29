# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Classes for orchestrating Python (virtual) environments"
HOMEPAGE="https://github.com/jaraco/jaraco.envs"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a7/10/233134945fdba69d4b87224e8a76bd39c6770a5215c3056d592b936d96d7/jaraco.envs-2.6.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jaraco.envs-2.6.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/path
	dev-pypi/tox
	dev-pypi/virtualenv
"
# lockstep-pypi-deps: end
