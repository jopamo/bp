# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="https://people.redhat.com/sgrubb/libcap-ng/"
SRC_URI="https://people.redhat.com/sgrubb/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--without-python
		--without-python3
		$(usex static-libs "--enable-static=yes" "--enable-static=no")
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
