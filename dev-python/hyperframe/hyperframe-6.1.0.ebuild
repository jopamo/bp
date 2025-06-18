# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="HTTP/2 framing layer for Python"
HOMEPAGE="
	https://python-hyper.org/projects/hyperframe/en/latest/
	https://pypi.org/project/hyperframe/
	https://github.com/python-hyper/hyperframe/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
