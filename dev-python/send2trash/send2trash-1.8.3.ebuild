# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=Send2Trash
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Sends files to the Trash (or Recycle Bin)"
HOMEPAGE="
	https://github.com/arsenetar/send2trash/
	https://pypi.org/project/Send2Trash/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
