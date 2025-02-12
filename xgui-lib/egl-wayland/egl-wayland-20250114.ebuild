# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="The EGLStream-based Wayland external platform"
HOMEPAGE="https://github.com/NVIDIA/egl-wayland"

SNAPSHOT=26ba0e3ee448ff83644bc2ffbe5d06d21c60ce44
SRC_URI="https://github.com/NVIDIA/egl-wayland/archive/${SNAPSHOT}.tar.gz -> egl-wayland-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/egl-wayland-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-dev/eglexternalplatform"
