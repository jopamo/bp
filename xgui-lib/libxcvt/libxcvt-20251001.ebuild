# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="VESA Coordinated Video Timings (CVT) modeline generation library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=40de74eb5d7c402f82fe1f61beea515d17bcdd2a
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcvt/-/archive/${SNAPSHOT}/libxcvt-${SNAPSHOT}.tar.bz2 -> libxcvt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcvt-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
