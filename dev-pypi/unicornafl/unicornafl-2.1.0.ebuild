# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Unicornafl"
HOMEPAGE="https://github.com/AFLplusplus/unicornafl"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/59/de/2907fa73a099a04a162a7fc1b81096a504f1a09904c6491e05d343894c73/unicornafl-2.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/unicornafl-2.1.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/unicorn
"
# lockstep-pypi-deps: end
