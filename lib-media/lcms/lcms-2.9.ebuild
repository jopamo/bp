# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="mirror://sourceforge/${PN}/lcms2-${PV}.tar.gz"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64"
IUSE="jpeg static-libs test tiff"

RDEPEND="
	jpeg? ( lib-media/libjpeg-turbo )
	tiff? ( >=lib-media/tiff-4.0.3-r6:0= )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/lcms2-${PV}"

src_configure() {
	local myeconfargs=(
		$(use_with jpeg)
		$(use_enable static-libs static)
		$(use_with tiff)
		--without-zlib
	)
	ECONF_SOURCE="${S}" \
	econf ${myeconfargs[@]}
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
