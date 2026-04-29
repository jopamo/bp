# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Settings management using Pydantic"
HOMEPAGE="https://github.com/pydantic/pydantic-settings"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/42/98/c8345dccdc31de4228c039a98f6467a941e39558da41c1744fbe29fa5666/pydantic_settings-2.14.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pydantic_settings-2.14.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pydantic
	dev-pypi/python-dotenv
	dev-pypi/typing-inspection
"
# lockstep-pypi-deps: end
