# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/hpack
	dev-pypi/hyperframe
"
# lockstep-pypi-deps: end
DESCRIPTION="HTTP/2 State-Machine based protocol implementation"
HOMEPAGE="
	https://python-hyper.org/projects/h2/en/stable/
	https://github.com/python-hyper/h2/
	https://pypi.org/project/h2/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-py/hyperframe-6.1[${PYTHON_USEDEP}]
	<dev-py/hyperframe-7[${PYTHON_USEDEP}]
	>=dev-py/hpack-4.1[${PYTHON_USEDEP}]
	<dev-py/hpack-5[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( hypothesis )
EPYTEST_XDIST=1
distutils_enable_tests pytest
