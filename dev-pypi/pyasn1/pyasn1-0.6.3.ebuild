# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Pure-Python implementation of ASN.1 types and DER/BER/CER codecs (X.208)"
HOMEPAGE="https://github.com/pyasn1/pyasn1"
LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5c/5f/6583902b6f79b399c9c40674ac384fd9cd77805f9e6205075f828ef11fb2/pyasn1-0.6.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pyasn1-0.6.3"
