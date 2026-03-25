# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Library providing generic access to the PCI bus and devices"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=38e6f15f839fba2c49982e7ad61cde681fd5d4d6
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/archive/${SNAPSHOT}/libpciaccess-${SNAPSHOT}.tar.bz2 -> libpciaccess-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libpciaccess-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
