# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson flag-o-matic

DESCRIPTION="The EGLStream-based Wayland external platform"
HOMEPAGE="https://github.com/NVIDIA/egl-wayland"
EGIT_REPO_URI="https://github.com/NVIDIA/egl-wayland.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-dev/eglexternalplatform"
