# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Makes it easy to load subpackages and functions on demand."
HOMEPAGE="https://pypi.org/project/lazy-loader/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/49/ac/21a1f8aa3777f5658576777ea76bfb124b702c520bbe90edf4ae9915eafa/lazy_loader-0.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/lazy_loader-0.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
