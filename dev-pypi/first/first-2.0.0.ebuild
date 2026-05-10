# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Return the first true value of an iterable."
HOMEPAGE="http://github.com/hynek/first/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/91/f0/7c4090ee35ead6e17c46b83ec04e354de42d1ff5e00876fc1c26c793e3b7/first-2.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/first-2.0.0"
