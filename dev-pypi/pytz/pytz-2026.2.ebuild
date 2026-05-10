# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="World timezone definitions, modern and historical"
HOMEPAGE="http://pythonhosted.org/pytz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ff/46/dd499ec9038423421951e4fad73051febaa13d2df82b4064f87af8b8c0c3/pytz-2026.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytz-2026.2"
