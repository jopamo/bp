# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 pypi

# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end

DESCRIPTION="Python bindings for Cairo"
HOMEPAGE="https://pycairo.readthedocs.io/"
LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND+=" >=xgui-lib/cairo-1.15.10"
DEPEND="${RDEPEND}"
BDEPEND="app-dev/pkgconf"

distutils_enable_tests pytest
