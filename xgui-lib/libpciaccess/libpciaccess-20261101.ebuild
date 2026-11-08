# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Library providing generic access to the PCI bus and devices"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=e33aa5fd28f63b9842e36c1a8a954577eec042e3
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/archive/${SNAPSHOT}/libpciaccess-${SNAPSHOT}.tar.bz2 -> libpciaccess-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libpciaccess-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
