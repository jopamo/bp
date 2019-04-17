# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="BSD tar command"
HOMEPAGE="http://www.libarchive.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libarchive/libarchive.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=e5ade325a7d97772e91444332b4f7d3cfaab24d7
	SRC_URI="https://github.com/libarchive/libarchive/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="BSD BSD-2 BSD-4 public-domain"
SLOT="0/1"
IUSE="acl +bzip2 expat lzo nettle static-libs xattr +zlib"

DEPEND="
	acl? ( sys-app/acl )
	bzip2? ( app-compression/lbzip2 )
	expat? ( lib-dev/expat )
	!expat? ( lib-dev/libxml2 )
	xattr? ( sys-app/attr )
	lib-dev/openssl:0=
	>=app-compression/lz4-0_p131:0=
	app-compression/xz-utils
	lzo? ( >=lib-dev/lzo-2 )
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
		--with-lz4
		--with-lzma
		--without-lzo2
		$(use_with nettle)
		$(use_with zlib)
		--disable-bsdcat
		--disable-bsdcpio
		--disable-bsdtar
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
