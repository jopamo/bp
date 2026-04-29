# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Parsing and validation of URIs (RFC 3986) and IRIs (RFC 3987)"
HOMEPAGE="http://pypi.python.org/pypi/rfc3987"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/14/bb/f1395c4b62f251a1cb503ff884500ebd248eed593f41b469f89caa3547bd/rfc3987-1.3.8.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rfc3987-1.3.8"
