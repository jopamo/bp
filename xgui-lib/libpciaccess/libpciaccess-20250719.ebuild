# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Library providing generic access to the PCI bus and devices"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=191dfe0707e2a93c08e4b3e99454b6146c5bfca2
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/archive/${SNAPSHOT}/libpciaccess-${SNAPSHOT}.tar.bz2 -> libpciaccess-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libpciaccess-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
