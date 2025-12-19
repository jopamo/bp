# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="MediaInfo libraries"
HOMEPAGE="https://mediaarea.net/mediainfo/ https://github.com/MediaArea/MediaInfoLib"
SNAPSHOT=4590c320d4a425991afc1178f26d91172187ece8
SRC_URI="https://github.com/MediaArea/MediaInfoLib/archive/${SNAPSHOT}.tar.gz -> MediaInfoLib-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/MediaInfoLib-${SNAPSHOT}/Project/GNU/Library"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la"

RESTRICT="test"

DEPEND="
	lib-dev/tinyxml2
	xmedia-lib/libzen
"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*

	default

	sed -i 's:-O2::' configure.ac || die
	append-cppflags -DMEDIAINFO_LIBMMS_DESCRIBE_SUPPORT=0

	eautoreconf
}

src_configure() {
	econf \
		--enable-shared \
		--disable-static \
		--disable-staticlibs \
		--with-libtinyxml2 \
		--without-libcurl \
		--without-libmms
}

src_install() {
	default

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
