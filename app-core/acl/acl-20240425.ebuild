# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="access control list utilities, libraries and headers"
HOMEPAGE="https://savannah.nongnu.org/projects/acl"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-core/attr"

replace-flags -O3 -O2

src_configure() {
	local myconf=(
		--enable-shared $(use_enable static-libs static)
		--disable-nls
	)
	econf "${myconf[@]}"
}
