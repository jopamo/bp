# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Read access to Windows Registry files."
HOMEPAGE="http://www.williballenthin.com/registry/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a4/82/c9ae8e9764eae863a4d63c05d5f2d767e392b523c2976c16c56f9a3b17b4/python-registry-1.3.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python-registry-1.3.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/enum-compat
	dev-pypi/unicodecsv
"
# lockstep-pypi-deps: end
