# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A modern multi-purpose calculator library"
HOMEPAGE="https://qalculate.github.io/"

SNAPSHOT=3d2b5dc3b3dce43e0e7b8e222c738bead571ad67
SRC_URI="https://github.com/Qalculate/libqalculate/archive/${SNAPSHOT}.tar.gz -> libqalculate-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libqalculate-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="curl icu gnuplot readline static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with curl libcurl) \
		$(use_with icu) \
		$(use_with readline)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		referencedir="${EPREFIX}/usr/share/doc/${PF}/html" \
		install

	find "${ED}" -name '*.la' -delete || die
}