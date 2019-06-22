# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="BSD tar command"
HOMEPAGE="http://www.libarchive.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libarchive/libarchive.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=a163558c388bb2ccedef683e8031c11193e6875c
	SRC_URI="https://github.com/libarchive/libarchive/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="BSD BSD-2 BSD-4 public-domain"
SLOT="0/1"

IUSE="acl +bzip2 expat lzo nettle static-libs xattr +zlib lz4 zstd"

DEPEND="
	acl? ( sys-app/acl )
	bzip2? ( app-compression/lbzip2 )
	expat? ( lib-dev/expat )
	!expat? ( lib-dev/libxml2 )
	xattr? ( sys-app/attr )
	lib-dev/openssl:0=
	lz4? ( app-compression/lz4 )
	zstd? ( app-compression/zstd )
	lzo? ( lib-dev/lzo )
	app-compression/xz-utils
	nettle? ( lib-dev/nettle:0= )
	zlib? ( lib-sys/zlib )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable acl)
		$(use_enable static-libs static)
		$(use_enable xattr)
		$(use_with bzip2 bz2lib)
		$(use_with expat)
		$(use_with !expat xml2)
		--with-iconv
		$(use_with lz4)
		$(use_with zstd)
		--with-lzma
		$(use_with lzo lzo2)
		$(use_with nettle)
		$(use_with zlib)
		--disable-bsdcat
		--disable-bsdcpio
		--disable-bsdtar
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
