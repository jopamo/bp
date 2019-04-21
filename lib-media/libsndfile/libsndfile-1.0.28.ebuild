# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit python-any-r1

DESCRIPTION="A C library for reading and writing files containing sampled sound"
HOMEPAGE="http://www.mega-nerd.com/libsndfile"

SRC_URI="http://www.mega-nerd.com/libsndfile/files/${P}.tar.gz"
KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="alsa minimal sqlite static-libs test"

RDEPEND="
	!minimal? (
		>=lib-media/flac-1.2.1-r5
		>=lib-media/libogg-1.3.0
		>=lib-media/libvorbis-1.3.3-r1
	)
	alsa? ( lib-media/alsa-lib )
	sqlite? ( >=lib-sys/sqlite-3.2 )"
DEPEND="
	${DEPEND}
	${RDEPEND}
	dev-util/pkgconfig
	test? ( ${PYTHON_DEPS} )"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
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

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
