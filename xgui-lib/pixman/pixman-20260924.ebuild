# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Low-level pixel manipulation routines"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=caa79f21a7460a0675aada3113e38c43b17bc4ae
SRC_URI="https://gitlab.freedesktop.org/pixman/pixman/-/archive/${SNAPSHOT}/pixman-${SNAPSHOT}.tar.bz2 -> pixman-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/pixman-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
