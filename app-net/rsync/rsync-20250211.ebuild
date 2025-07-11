# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="https://rsync.samba.org/"

SNAPSHOT=9994933c8ccf7ead27c81fe4ce2eb4e08af20c7f
SRC_URI="https://github.com/RsyncProject/rsync/archive/${SNAPSHOT}.tar.gz -> rsync-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/rsync-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl iconv ipv6 lz4 static xattr xxhash zstd"

LIB_DEPEND="
	lib-core/zlib[static-libs(+)]
	virtual/ssl[static-libs(+)]
	acl? ( app-core/acl[static-libs(+)] )
	lz4? ( app-compression/lz4[static-libs(+)] )
	xattr? ( app-core/attr[static-libs(+)] )
	xxhash? ( lib-misc/xxhash[static-libs(+)] )
	zstd? ( app-compression/zstd[static-libs(+)] )
"

DEPEND="
	!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	static? ( ${LIB_DEPEND} )
"

src_prepare() {
	rm zlib/*.{c,h} || die
	rm config.{guess,sub} || die
	cp -p "${EROOT}"/usr/share/gnuconfig/* "${S}"/
	default
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		$(use_enable acl acl-support)
		$(use_enable iconv)
		$(use_enable ipv6)
		$(use_enable lz4)
		$(use_enable xattr xattr-support)
		$(use_enable xxhash)
		$(use_enable zstd)
		--disable-md2man
		--without-included-zlib
		--with-included-popt=no
	)
	econf "${myconf[@]}"
}
