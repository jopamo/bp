# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Tool which allows you to compose wallpapers ('root pixmaps') for X"
SRC_URI="
	mirror://debian/pool/main/h/${PN}/${PN}_${PV/_p*/}.orig.tar.gz
	mirror://debian/pool/main/h/${PN}/${PN}_${PV/_p*/}-${PV/*_p/}.debian.tar.xz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-media/imlib2[X]
	x11-live-libs/libX11
	x11-live-misc/xorgproto"

PATCHES=(
	"${FILESDIR}"/hsetroot-1.0.2-underlinking.patch
	"${WORKDIR}"/debian/patches/01_fix-no-display-crash.patch
	"${WORKDIR}"/debian/patches/02_extend-mode.patch
	"${WORKDIR}"/debian/patches/03_cover-mode.patch
)

S=${WORKDIR}/${P/_p*/}.orig

src_prepare() {
	default
	eautoreconf
}
