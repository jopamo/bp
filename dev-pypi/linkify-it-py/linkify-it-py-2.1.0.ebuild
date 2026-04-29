# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Links recognition library with FULL unicode support."
HOMEPAGE="https://github.com/tsutsu3/linkify-it-py"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/2e/c9/06ea13676ef354f0af6169587ae292d3e2406e212876a413bf9eece4eb23/linkify_it_py-2.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/linkify_it_py-2.1.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/uc-micro-py
"
# lockstep-pypi-deps: end
