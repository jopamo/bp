# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Low-level pixel manipulation routines"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=e5f8efc4c740aed8f210bbd379d961ecd951b7d2
SRC_URI="https://gitlab.freedesktop.org/pixman/pixman/-/archive/${SNAPSHOT}/pixman-${SNAPSHOT}.tar.bz2 -> pixman-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/pixman-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
