# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Handler library for evdev events"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libevdev/"

SNAPSHOT=ac0056961c3332a260db063ab4fccc7747638a1d
SRC_URI="https://gitlab.freedesktop.org/libevdev/libevdev/-/archive/${SNAPSHOT}/libevdev-${SNAPSHOT}.tar.bz2 -> libevdev-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libevdev-${SNAPSHOT}"

LICENSE="X11"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test" # Tests need to run as root.

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
