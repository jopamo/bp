# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal

DESCRIPTION="Handler library for evdev events"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libevdev/"

SRC_URI="https://www.freedesktop.org/software/libevdev/${P}.tar.xz"
SLOT=0
RESTRICT="test" # Tests need to run as root.
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
