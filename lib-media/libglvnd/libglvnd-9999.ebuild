# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 python-any-r1

DESCRIPTION="The GL Vendor-Neutral Dispatch library"
HOMEPAGE="https://github.com/NVIDIA/libglvnd"
EGIT_REPO_URI="https://github.com/NVIDIA/${PN}.git"

KEYWORDS="amd64 arm64"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	!media-libs/mesa[-libglvnd(-)]
	x11-libs/libX11
	"
DEPEND="${PYTHON_DEPS}
	${RDEPEND}"

PATCHES=( ${FILESDIR}/Add-pkgconfig-data-for-libraries-implemented-so-far.patch )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} econf
}

src_install() {
	default
	insinto	usr/lib/pkgconfig
	doins ${FILESDIR}/glesv2.pc

	rm -f "${ED}"/usr/lib/pkgconfig/egl.pc
}
