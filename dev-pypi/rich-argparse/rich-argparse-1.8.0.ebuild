# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Rich help formatters for argparse and optparse"
HOMEPAGE="https://github.com/hamdanal/rich-argparse"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6a/e5/1064c43203a357d668cd42435f7a15fe6af51512d85b2104fecb937aa861/rich_argparse-1.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rich_argparse-1.8.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/rich
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_test() (
	# The help snapshots include ANSI sequences even in a noninteractive build.
	unset NO_COLOR
	epytest
)
