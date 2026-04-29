# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Virtual Python Environment builder"
HOMEPAGE="https://github.com/pypa/virtualenv"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/aa/92/58199fe10049f9703c2666e809c4f686c54ef0a68b0f6afccf518c0b1eb9/virtualenv-21.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/virtualenv-21.2.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/distlib
	dev-pypi/filelock
	dev-pypi/platformdirs
	dev-pypi/python-discovery
"
# lockstep-pypi-deps: end
