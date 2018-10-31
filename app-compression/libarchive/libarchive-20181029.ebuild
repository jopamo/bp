# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils libtool multilib-minimal toolchain-funcs autotools

DESCRIPTION="BSD tar command"
HOMEPAGE="http://www.libarchive.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libarchive/libarchive.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=8e14bfedb8759a58724cb611323d010aa55aea5e
	SRC_URI="https://github.com/libarchive/libarchive/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="BSD BSD-2 BSD-4 public-domain"
SLOT="0/1"
IUSE="acl +bzip2 expat libressl lzo nettle static-libs xattr +zlib"

DEPEND="
	acl? ( sys-app/acl[${MULTILIB_USEDEP}] )
	bzip2? ( app-compression/lbzip2[${MULTILIB_USEDEP}] )
	expat? ( lib-dev/expat[${MULTILIB_USEDEP}] )
	!expat? ( lib-dev/libxml2[${MULTILIB_USEDEP}] )
	xattr? ( sys-app/attr[${MULTILIB_USEDEP}] )
	!libressl? ( lib-dev/openssl:0=[${MULTILIB_USEDEP}] )
	libressl? ( lib-dev/libressl:0=[${MULTILIB_USEDEP}] )
	>=app-compression/lz4-0_p131:0=[${MULTILIB_USEDEP}]
	app-compression/xz-utils[${MULTILIB_USEDEP}]
	lzo? ( >=lib-dev/lzo-2[${MULTILIB_USEDEP}] )
	nettle? ( lib-dev/nettle:0=[${MULTILIB_USEDEP}] )
	zlib? ( lib-sys/zlib[${MULTILIB_USEDEP}] )"

src_prepare() {
	eautoreconf
	default
}
multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
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

multilib_src_compile() {
	if multilib_is_native_abi ; then
		emake
	else
		emake libarchive.la
	fi
}

multilib_src_test() {
	multilib_is_native_abi && emake check
}

multilib_src_install() {
	if multilib_is_native_abi ; then
		emake DESTDIR="${D}" install
	else
		local install_targets=(
			install-includeHEADERS
			install-libLTLIBRARIES
			install-pkgconfigDATA
		)
		emake DESTDIR="${D}" "${install_targets[@]}"
	fi
}

