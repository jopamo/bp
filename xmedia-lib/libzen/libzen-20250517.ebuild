# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Shared library for libmediainfo and mediainfo"
HOMEPAGE="https://github.com/MediaArea/ZenLib"

SNAPSHOT=f5f6974b92ce9d9fefb6fd5f9f78c756e5ac3644
SRC_URI="https://github.com/MediaArea/ZenLib/archive/${SNAPSHOT}.tar.gz -> ZenLib-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ZenLib-${SNAPSHOT}/Project/GNU/Library"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la static-libs"

DEPEND="app-dev/pkgconf"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*
	default
	sed -i 's:-O2::' configure.ac || die
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-unicode
		--enable-shared
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insinto /usr/lib/pkgconfig
	doins libzen.pc

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
