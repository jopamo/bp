# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Extract data from python stack frames and tracebacks for informative displays"
HOMEPAGE="http://github.com/alexmojaki/stack_data"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/28/e3/55dcc2cfbc3ca9c29519eb6884dd1415ecb53b0e934862d3559ddcb7e20b/stack_data-0.6.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/stack_data-0.6.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/asttokens
	dev-pypi/executing
	dev-pypi/pure-eval
"
# lockstep-pypi-deps: end
