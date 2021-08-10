# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Extended attributes tools"
HOMEPAGE="https://savannah.nongnu.org/projects/attr"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls static-libs debug"

PATCHES=("${FILESDIR}/00_8d7fa4cc89713e3e98afeec7cc6f1002855d4ac3.patch")

src_configure() {
	local myconf=(
		--enable-shared
		$(use_enable static-libs static)
		$(use_enable nls)
		$(use_enable debug)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	insinto /usr/include/attr
	newins "${FILESDIR}"/xattr-shim.h xattr.h
}
