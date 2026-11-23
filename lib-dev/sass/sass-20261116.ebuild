# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="A C/C++ implementation of a Sass CSS compiler"
HOMEPAGE="https://github.com/sass/libsass"

SNAPSHOT=3e63f12837fcc790e52ce46e78906b06d9cfe9d8
SRC_URI="https://gitlab.com/pjo/sass/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
