# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Epoxy is a library for handling OpenGL function pointer management for you"
HOMEPAGE="https://github.com/anholt/libepoxy"
SNAPSHOT=d1f952c4565c389d82fd1657153e84e050f35b27
SRC_URI="https://github.com/anholt/libepoxy/archive/${SNAPSHOT}.tar.gz -> libepoxy-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libepoxy-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-tools/mesa
	xgui-tools/util-macros
"
