# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X server implementation of the VESA CVT"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=dd8631c61465cc0de5e476c7a98e56528d62b163
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcvt/-/archive/${SNAPSHOT}/libxcvt-${SNAPSHOT}.tar.bz2 -> libxcvt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcvt-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
