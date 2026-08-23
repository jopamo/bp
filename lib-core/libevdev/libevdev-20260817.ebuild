# Distributed under the terms of the GNU General Public License v2

inherit autotools flag-o-matic qa-policy

DESCRIPTION="Handler library for evdev events"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libevdev/"
SNAPSHOT=a158f468affb059669189454a52b0d78c563618b
SRC_URI="https://gitlab.freedesktop.org/libevdev/libevdev/-/archive/${SNAPSHOT}/libevdev-${SNAPSHOT}.tar.bz2 -> libevdev-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libevdev-${SNAPSHOT}"

LICENSE="X11"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RESTRICT="test" # Tests need to run as root.

src_prepare() {
	qa-policy-configure
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
