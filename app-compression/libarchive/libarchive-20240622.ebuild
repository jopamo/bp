# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Multi-format archive and compression library"
HOMEPAGE="http://www.libarchive.org/"

SNAPSHOT=898dc8319355b7e985f68a9819f182aaed61b53a
SRC_URI="https://github.com/libarchive/libarchive/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD BSD-2 BSD-4 public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl +bsdtar +bzip2 expat lz4 nettle ssl static-libs xattr +zlib zstd"

DEPEND="
	app-compression/xz-utils
	!expat? ( lib-core/libxml2 )
	acl? ( app-core/acl )
	bzip2? ( app-compression/bzip2 )
	expat? ( lib-core/expat )
	lz4? ( app-compression/lz4 )
	nettle? ( lib-core/nettle )
	ssl? ( virtual/ssl )
	xattr? ( app-core/attr )
	zlib? ( lib-core/zlib )
	zstd? ( app-compression/zstd )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable acl)
		$(use_enable bsdtar)
		$(use_enable static-libs static)
		$(use_enable xattr)
		$(use_with !expat xml2)
		$(use_with bzip2 bz2lib)
		$(use_with expat)
		$(use_with lz4)
		$(use_with nettle)
		$(use_with ssl openssl)
		$(use_with zlib)
		$(use_with zstd)
		--disable-bsdcat
		--disable-bsdcpio
		--with-iconv
		--with-lzma
		--without-lzo2
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
