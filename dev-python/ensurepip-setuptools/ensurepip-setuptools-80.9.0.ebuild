# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pypi

DESCRIPTION="Shared setuptools wheel for ensurepip Python module"
HOMEPAGE="https://pypi.org/project/setuptools/"
SRC_URI="$(pypi_wheel_url "${PN#ensurepip-}")"
S=${DISTDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	insinto /usr/lib/python/ensurepip
	doins "${A}"
}
