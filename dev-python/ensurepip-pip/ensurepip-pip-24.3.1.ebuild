# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pypi

DESCRIPTION="Shared pip wheel for ensurepip Python module"
HOMEPAGE="https://pypi.org/project/pip/"
SRC_URI="$(pypi_wheel_url "${PN#ensurepip-}")"
S=${DISTDIR}

LICENSE="Apache-2.0 BSD BSD-2 ISC LGPL-2.1+ MIT MPL-2.0 PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	!<dev-python/ensurepip-wheels-100
"

src_install() {
	insinto /usr/lib/python/ensurepip
	doins "${A}"
}
