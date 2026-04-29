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

SRC_URI="https://files.pythonhosted.org/packages/ac/25/6d0481860583f44953bd791de0b7c4f6d7ead7223f8a17e776247b34a5b4/cloudscraper-1.2.71.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cloudscraper-1.2.71"
