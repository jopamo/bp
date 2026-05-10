# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Libfuzzer bindings for Unicorn.."
HOMEPAGE="https://github.com/wtdcode/fuzzercorn"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b8/e5/11b3046e73d13e451bc6e9436fe412c903c5f95ebf9db1d29d0f8e7b834f/fuzzercorn-0.0.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fuzzercorn-0.0.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/unicorn
"
# lockstep-pypi-deps: end
