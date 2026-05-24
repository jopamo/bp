# Distributed under the terms of the GNU General Public License v2

inherit qa-policy

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SNAPSHOT=d261ab6fda30fd7578a2ce7ace5c0b2c7d3fc0b8
SRC_URI="https://github.com/ImageMagick/lcms/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="jpeg static-libs test tiff"

DEPEND="
	jpeg? ( xmedia-lib/libjpeg-turbo )
	tiff? ( >=xmedia-lib/tiff-4.0.3-r6:0= )
"

src_prepare() {
	qa-policy-configure
	default
}

src_configure() {
	local myconf=(
		$(use_with jpeg)
		$(use_enable static-libs static)
		$(use_with tiff)
		--without-zlib
	)
	ECONF_SOURCE="${S}" econf ${myconf[@]}
}

src_install() {
	default
	qa-policy-install
}
