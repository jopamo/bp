# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="C library for the Public Suffix List"
HOMEPAGE="https://github.com/rockdaboot/libpsl"
SRC_URI="https://github.com/rockdaboot/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local myconf=(
		--disable-asan
		--disable-cfi
		--disable-ubsan
		--disable-static
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
