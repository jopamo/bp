# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=1dd86d835b27ed149b66aee1a4853d1db8a1f44c

inherit autotools

DESCRIPTION="library for developing printing features, split out of cups-filters"
HOMEPAGE="https://github.com/OpenPrinting/libcupsfilters"

SRC_URI="https://github.com/OpenPrinting/libcupsfilters/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="dbus exif jpeg pdf poppler postscript png test tiff"

RESTRICT="!test? ( test )"

RDEPEND="
	>=app-tex/qpdf-8.3.0:=
	fonts/fontconfig
	xgui-lib/lcms

	exif? ( xmedia-lib/libexif )
	dbus? ( app-core/dbus )
	jpeg? ( xmedia-lib/libjpeg-turbo )
	pdf? ( app-tex/mupdf )
	postscript? ( app-tex/ghostscript-gpl[cups] )
	poppler? ( app-tex/poppler )
	png? ( xmedia-lib/libpng )
	tiff? ( xmedia-lib/tiff )
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-imagefilters
		--localstatedir="${EPREFIX}"/var
		--with-cups-rundir="${EPREFIX}"/run/cups

		$(use_enable exif)
		$(use_enable dbus)
		$(use_enable poppler)
		$(use_enable postscript ghostscript)
		$(use_enable pdf mutool)
		$(use_with jpeg)
		$(use_with png)
		$(use_with tiff)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
