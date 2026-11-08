# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="A C/C++ implementation of a Sass CSS compiler"
HOMEPAGE="https://github.com/sass/libsass"

SNAPSHOT=3de4ca3fa1dc7d7a7d91944789bafded2207cfc4
SRC_URI="https://gitlab.com/pjo/sass/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
