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
	xgui-app/mpg123
"

src_prepare() {
	default
	sed -i 's/ret = id3v2_add_utf8_lng(gfp, ID_GENRE, 0, text);/char *utf8 = local_strdup_utf16_to_latin1(text); ret = id3v2_add_utf8_lng(gfp, ID_GENRE, 0, utf8); free(utf8);/' libmp3lame/id3tag.c || die

	sed -i 's%return id3tag_set_userinfo_utf8(gfp, frame_id, text);%{char *utf8 = local_strdup_utf16_to_latin1(text); int r = id3tag_set_userinfo_utf8(gfp, frame_id, utf8); free(utf8); return r;}%' libmp3lame/id3tag.c || die

	sed -i 's%return id3tag_set_genre_utf8(gfp, text);%{char *utf8 = local_strdup_utf16_to_latin1(text); int r = id3tag_set_genre_utf8(gfp, (unsigned short *)utf8); free(utf8); return r;}%' libmp3lame/id3tag.c || die

	sed -i 's%return id3v2_add_utf8_lng(gfp, frame_id, 0, text);%{char *utf8 = local_strdup_utf16_to_latin1(text); int r = id3v2_add_utf8_lng(gfp, frame_id, 0, utf8); free(utf8); return r;}%' libmp3lame/id3tag.c || die

	sed -i 's%return id3v2_add_utf8_lng(gfp, frame_id, text, 0);%{char *utf8 = local_strdup_utf16_to_latin1(text); int r = id3v2_add_utf8_lng(gfp, frame_id, utf8, 0); free(utf8); return r;}%' libmp3lame/id3tag.c || die
}

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
