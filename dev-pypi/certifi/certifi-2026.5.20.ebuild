# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python package for providing Mozilla's CA Bundle."
HOMEPAGE="https://github.com/certifi/python-certifi"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f3/ce/ee2ecad540810a79593028e88299baeae54d346cc7a0d94b6199988b89b1/certifi-2026.5.20.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/certifi-2026.5.20"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
