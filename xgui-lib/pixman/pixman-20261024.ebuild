# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Low-level pixel manipulation routines"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=e7fd44140fe6edef507d54bdbc25c09543ffc936
SRC_URI="https://gitlab.freedesktop.org/pixman/pixman/-/archive/${SNAPSHOT}/pixman-${SNAPSHOT}.tar.bz2 -> pixman-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/pixman-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
