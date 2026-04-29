# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A Python module to bypass Cloudflare's anti-bot page."
HOMEPAGE="https://github.com/venomous/cloudscraper"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/06/68/0ea9c9df3a50b21b70876b257ad9e24eb252c4ce92c3cecf2428ba852cbe/cloudscraper-1.2.69.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cloudscraper-1.2.69"
