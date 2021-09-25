# Distributed under the terms of the GNU General Public License v2

EAPI=8


inherit python-any-r1

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile"
SRC_URI="https://github.com/libsndfile/libsndfile/releases/download/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa minimal sqlite static-libs test"

RDEPEND="
	!minimal? (
		>=xmedia-live-lib/flac-1.2.1-r5
		>=xmedia-live-lib/libogg-1.3.0
		>=xmedia-live-lib/libvorbis-1.3.3-r1
	)
	alsa? ( xmedia-live-lib/alsa-lib )
	sqlite? ( >=lib-core/sqlite-3.2 )"
DEPEND="
	${DEPEND}
	${RDEPEND}
	dev-util/pkgconf
	test? ( ${PYTHON_DEPS} )"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-octave
		$(use_enable static-libs static)
		$(use_enable !minimal external-libs)
		$(use_enable alsa)
		$(use_enable sqlite)
		PYTHON="${EPYTHON}"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
