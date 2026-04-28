# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="A C/C++ implementation of a Sass CSS compiler"
HOMEPAGE="https://github.com/sass/libsass"

SNAPSHOT=1dea0d3641b22bc6c5577721cba28c28aed1cfa7
SRC_URI="https://gitlab.com/pjo/sass/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
