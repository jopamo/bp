# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Handler library for evdev events"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libevdev/"
SRC_URI="https://www.freedesktop.org/software/libevdev/${P}.tar.xz"

LICENSE="X11"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test" # Tests need to run as root.

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
