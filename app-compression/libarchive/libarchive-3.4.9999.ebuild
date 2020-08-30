# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="BSD tar command"
HOMEPAGE="http://www.libarchive.org/"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/libarchive/libarchive.git"
	EGIT_BRANCH="$(ver_cut 1-2)"
	inherit git-r3
else
	SNAPSHOT=34940ef6ea0b21d77cb501d235164ad88f19d40c
	SRC_URI="https://github.com/libarchive/libarchive/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD BSD-2 BSD-4 public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl +bsdtar +bzip2 expat nettle ssl static-libs xattr +zlib ssl lz4 zstd"

DEPEND="
	acl? ( sys-app/acl )
	bzip2? ( app-compression/lbzip2 )
	expat? ( lib-dev/expat )
	!expat? ( lib-dev/libxml2 )
	xattr? ( sys-app/attr )
	ssl? ( virtual/ssl )
	lz4? ( app-compression/lz4 )
	zstd? ( app-compression/zstd )
	app-compression/xz-utils
	nettle? ( lib-dev/nettle:0= )
	zlib? ( lib-sys/zlib )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		$(use_enable acl)
		$(use_enable bsdtar)
		$(use_enable static-libs static)
		$(use_enable xattr)
		$(use_with bzip2 bz2lib)
		$(use_with expat)
		$(use_with !expat xml2)
		$(use_with lz4)
		$(use_with zstd)
		$(use_with nettle)
		$(use_with zlib)
		--with-lzma
		--with-iconv
		--without-lzo2
		--disable-bsdcat
		--disable-bsdcpio
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
