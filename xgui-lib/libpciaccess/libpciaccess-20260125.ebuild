# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Library providing generic access to the PCI bus and devices"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=30cfe2325d816991610a8224a49cfa12317d7f67
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/archive/${SNAPSHOT}/libpciaccess-${SNAPSHOT}.tar.bz2 -> libpciaccess-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libpciaccess-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
