# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Strict, simple, lightweight RFC3339 functions"
HOMEPAGE="http://www.danielrichman.co.uk/libraries/strict-rfc3339.html"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/56/e4/879ef1dbd6ddea1c77c0078cd59b503368b0456bcca7d063a870ca2119d3/strict-rfc3339-0.7.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/strict-rfc3339-0.7"
