# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Stream-oriented XML parser library"
HOMEPAGE="https://libexpat.github.io/"
SRC_URI="https://github.com/libexpat/libexpat/releases/download/R_${PV//\./_}/expat-${PV}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	local myconf="$(use_enable static-libs static) --without-docbook"

	ECONF_SOURCE="${S}" econf ${myconf}
}
