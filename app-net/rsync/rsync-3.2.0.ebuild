# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic autotools

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="https://rsync.samba.org/"
SRC_URI="https://download.samba.org/pub/rsync/src/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl iconv ipv6 lz4 static xattr +xxhash zstd"

LIB_DEPEND="acl? ( sys-app/acl[static-libs(+)] )
	xattr? ( sys-app/attr[static-libs(+)] )
	xxhash? ( lib-dev/xxhash[static-libs(+)] )
	zstd? ( app-compression/zstd[static-libs(+)] )
	lz4? ( app-compression/lz4[static-libs(+)] )"

RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"

DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

PATCHES=( "${FILESDIR}"/simd.patch
	"${FILESDIR}"/noreconfigure.patch )

append-ldflags -Wl,-z,noexecstack

src_prepare() {
	rm -f zlib/*.{c,h} || die
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--without-included-zlib
		$(use_enable acl acl-support)
		$(use_enable iconv)
		$(use_enable ipv6)
		$(use_enable lz4)
		$(use_enable xattr xattr-support)
		$(use_enable xxhash)
		$(use_enable zstd)
	)
	econf "${myconf[@]}"
}
