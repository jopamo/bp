# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="pyasn1"
DESCRIPTION="Pure-Python implementation of ASN.1 types and DER/BER/CER codecs (X.208)"
HOMEPAGE="https://github.com/pyasn1/pyasn1"
LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"
