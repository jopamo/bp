# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="LAME Ain't an MP3 Encoder"
HOMEPAGE="http://lame.sourceforge.net/"
SRC_URI="https://1g4.org/files/lame-svn-r$(ver_cut 2)-trunk.zip"
S="${WORKDIR}/lame-svn-r$(ver_cut 2)-trunk/lame"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

DEPEND="
	app-lang/nasm
	xgui-misc/mpg123
"

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable debug debug norm)
		--disable-mp3x
		--enable-dynamic-frontends
		--enable-nasm
		--disable-frontend
		--disable-mp3rtp
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
