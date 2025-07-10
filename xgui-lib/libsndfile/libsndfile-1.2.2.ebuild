# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-any-r1

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile"
SRC_URI="https://github.com/libsndfile/libsndfile/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa minimal sqlite static-libs test"

RDEPEND="
	alsa? ( xgui-tools/alsa-lib )
	!minimal? (
		xmedia-lib/flac
		xmedia-lib/libogg
		xmedia-lib/libvorbis
	)
	sqlite? ( lib-core/sqlite )"
DEPEND="
	${RDEPEND}
	test? ( ${PYTHON_DEPS} )"

src_configure() {
	local myconf=(
		$(use_enable !minimal external-libs)
		$(use_enable alsa)
		$(use_enable sqlite)
		$(use_enable static-libs static)
		--disable-octave
		PYTHON="${EPYTHON}"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
