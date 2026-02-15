# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="VESA Coordinated Video Timings (CVT) modeline generation library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=bfca4a27f9e8bada2469573653da75536c578946
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcvt/-/archive/${SNAPSHOT}/libxcvt-${SNAPSHOT}.tar.bz2 -> libxcvt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcvt-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
