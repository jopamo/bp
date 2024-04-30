# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="The EGLStream-based Wayland external platform"
HOMEPAGE="https://github.com/NVIDIA/egl-wayland"

SNAPSHOT=067e43d0d4af82e4ea3fdc8ce476e6a24f69956f
SRC_URI="https://github.com/NVIDIA/egl-wayland/archive/${SNAPSHOT}.tar.gz -> egl-wayland-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/egl-wayland-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-dev/eglexternalplatform"
