# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="VESA Coordinated Video Timings (CVT) modeline generation library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=049b79b74a42dfdc5feea6dd9b98256269610935
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcvt/-/archive/${SNAPSHOT}/libxcvt-${SNAPSHOT}.tar.bz2 -> libxcvt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcvt-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
