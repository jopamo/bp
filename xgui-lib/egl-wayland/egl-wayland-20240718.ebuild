# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="The EGLStream-based Wayland external platform"
HOMEPAGE="https://github.com/NVIDIA/egl-wayland"

SNAPSHOT=081139808a7548cca5eec41be16a06ed3e9a5458
SRC_URI="https://github.com/NVIDIA/egl-wayland/archive/${SNAPSHOT}.tar.gz -> egl-wayland-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/egl-wayland-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-dev/eglexternalplatform"
