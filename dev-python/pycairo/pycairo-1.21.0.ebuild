# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 flag-o-matic

DESCRIPTION="Python bindings for the cairo library"
HOMEPAGE="https://www.cairographics.org/pycairo/ https://github.com/pygobject/pycairo"
SRC_URI="https://github.com/pygobject/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs
