# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Pure-Python HTTP/2 protocol implementation"
HOMEPAGE="https://github.com/python-hyper/h2/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1d/17/afa56379f94ad0fe8defd37d6eb3f89a25404ffc71d4d848893d270325fc/h2-4.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/h2-4.3.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/hpack
	dev-pypi/hyperframe
"
# lockstep-pypi-deps: end
