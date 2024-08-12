# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="X server implementation of the VESA CVT"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=922c7e1fb5f976765524ab9ab47567582a9f66dd
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcvt/-/archive/${SNAPSHOT}/libxcvt-${SNAPSHOT}.tar.bz2 -> libxcvt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcvt-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
