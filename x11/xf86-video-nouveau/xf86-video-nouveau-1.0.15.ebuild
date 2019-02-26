# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Accelerated Open Source driver for nVidia cards"
HOMEPAGE="https://nouveau.freedesktop.org/wiki/"
SRC_URI="https://www.x.org/archive/individual/driver/${P}.tar.bz2"
SLOT=0

KEYWORDS="amd64 arm64"

RDEPEND=">=x11-libs/libdrm-2.4.60[video_cards_nouveau]
	>=x11-libs/libpciaccess-0.10"
DEPEND="${RDEPEND}"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
