# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Extended attributes tools"
HOMEPAGE="https://savannah.nongnu.org/projects/attr"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs debug"

src_configure() {
	filter-flags -flto*

	local myconf=(
		--enable-shared
		$(use_enable static-libs static)
		--disable-nls
		$(use_enable debug)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	insinto /usr/include/attr
	newins "${FILESDIR}"/xattr-shim.h xattr.h
}
