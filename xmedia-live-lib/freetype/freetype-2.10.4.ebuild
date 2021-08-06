# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic libtool toolchain-funcs

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="https://www.freetype.org/"
IUSE="bzip2 debug harfbuzz png static-libs"

SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.xz
		mirror://gnu/freetype/${P/_/}.tar.xz"

KEYWORDS="amd64 arm64"

LICENSE="|| ( FTL GPL-2+ )"
SLOT="2"

RDEPEND=">=lib-core/zlib-1.2.8-r1
	bzip2? ( >=app-compression/bzip2-1.0.6 )
	harfbuzz? ( >=xmedia-live-lib/harfbuzz-1.3.0[truetype] )
	png? ( >=xmedia-live-lib/libpng-1.2.51:0= )"

DEPEND="${RDEPEND}
	dev-util/pkgconf"

append-flags -fno-strict-aliasing

src_prepare() {
	default

	enable_option() {
		sed -i -e "/#define $1/ { s:/\* ::; s: \*/:: }" \
			include/${PN}/config/ftoption.h \
			|| die "unable to enable option $1"
	}

	disable_option() {
		sed -i -e "/#define $1/ { s:^:/* :; s:$: */: }" \
			include/${PN}/config/ftoption.h \
			|| die "unable to disable option $1"
	}

	enable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  2"
	enable_option PCF_CONFIG_OPTION_LONG_FAMILY_NAMES
	enable_option FT_CONFIG_OPTION_SUBPIXEL_RENDERING

	if use debug; then
		enable_option FT_DEBUG_LEVEL_TRACE
		enable_option FT_DEBUG_MEMORY
	fi

	# we need non-/bin/sh to run configure
	if [[ -n ${CONFIG_SHELL} ]] ; then
		sed -i -e "1s:^#![[:space:]]*/bin/sh:#!$CONFIG_SHELL:" \
			"${S}"/builds/unix/configure || die
	fi

	elibtoolize --patch-only
}

src_configure() {
	append-flags -fno-strict-aliasing
	type -P gmake &> /dev/null && export GNUMAKE=gmake

	local myconf=(
		--enable-freetype-config
		--enable-biarch-config
		--enable-shared
		$(use_with bzip2)
		$(use_with harfbuzz)
		$(use_with png)
		$(use_enable static-libs static)

		# avoid using libpng-config
		LIBPNG_CFLAGS="$($(tc-getPKG_CONFIG) --cflags libpng)"
		LIBPNG_LDFLAGS="$($(tc-getPKG_CONFIG) --libs libpng)"
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default

	if ! use static-libs ; then
		find "${ED}" -name '*.a' -delete || die
	fi
}
